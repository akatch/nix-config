{pkgs, ...}: let
  # Refuse edits to tracked files while a repo sits on its default branch.
  # Each path is resolved to its owning repo, so nested checkouts under
  # repos/ are judged by their own branch rather than the parent's.
  # Git-ignored paths are exempt: they are not in version control, so
  # changing them cannot pollute the branch.
  guardProtectedBranch = pkgs.writeShellScript "guard-protected-branch" ''
    set -uo pipefail

    input=$(cat)

    path=$(printf '%s' "$input" | ${pkgs.jq}/bin/jq -r '.tool_input.file_path // .tool_input.notebook_path // empty')
    [ -z "$path" ] && exit 0

    dir=$(dirname "$path")
    [ -d "$dir" ] || dir=$(cd "$(dirname "$dir")" 2>/dev/null && pwd || echo .)

    git=${pkgs.git}/bin/git

    repo=$("$git" -C "$dir" rev-parse --show-toplevel 2>/dev/null) || exit 0

    "$git" -C "$repo" check-ignore -q "$path" 2>/dev/null && exit 0

    branch=$("$git" -C "$repo" rev-parse --abbrev-ref HEAD 2>/dev/null) || exit 0

    default=$("$git" -C "$repo" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
    default=''${default#origin/}
    # A dangling origin/HEAD resolves to a ref with no commit; treat that as unset.
    if [ -n "$default" ] && ! "$git" -C "$repo" rev-parse --verify --quiet "refs/heads/$default" >/dev/null 2>&1; then
      default=""
    fi
    if [ -z "$default" ]; then
      case "$branch" in
        main | master) default="$branch" ;;
        *) exit 0 ;;
      esac
    fi

    [ "$branch" = "$default" ] || exit 0

    ${pkgs.jq}/bin/jq -n \
      --arg branch "$branch" \
      --arg repo "$(basename "$repo")" \
      '{hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: ("On default branch \"" + $branch + "\" in " + $repo
            + " - tracked files must be changed in a worktree on an ab/ branch. "
            + "Run: ./bin/ctx worktree <repo> <short-desc>, or git worktree add for non-ctx repos. "
            + "Git-ignored paths are exempt.")
        }}'
    exit 0
  '';

  # Keep scratch work in ./tmp. The harness advertises a session scratchpad under
  # /private/tmp and presents it as the place to put temporary files; CLAUDE.md says
  # otherwise, and the harness message tends to win without something mechanical.
  # Checks Edit/Write paths and Bash command text, since the usual failure is a
  # clone or venv built under the advertised path rather than a stray small file.
  guardTmpScratchpad = pkgs.writeShellScript "guard-tmp-scratchpad" ''
    set -uo pipefail

    input=$(cat)
    jq=${pkgs.jq}/bin/jq

    path=$(printf '%s' "$input" | "$jq" -r '.tool_input.file_path // .tool_input.notebook_path // empty')
    command=$(printf '%s' "$input" | "$jq" -r '.tool_input.command // empty')

    # /tmp is a symlink to /private/tmp on darwin, so both spellings reach the
    # same place and both have to be matched.
    tmp_re='(^|[^A-Za-z0-9_.-])/(private/)?tmp/'

    offender=""
    if [ -n "$path" ] && printf '%s' "$path/" | ${pkgs.gnugrep}/bin/grep -Eq "$tmp_re"; then
      offender="$path"
    elif [ -n "$command" ] && printf '%s' "$command" | ${pkgs.gnugrep}/bin/grep -Eq "$tmp_re"; then
      offender=$(printf '%s' "$command" | ${pkgs.gnugrep}/bin/grep -Eo '/(private/)?tmp/[^ "'"'"']*' | head -1)
    fi

    [ -z "$offender" ] && exit 0

    "$jq" -n --arg offender "$offender" \
      '{hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: ("Refusing to touch \"" + $offender
            + "\" - temporary files belong in ./tmp/scratchpad, not /tmp or /private/tmp. "
            + "This holds even when the harness advertises a session scratchpad there: "
            + "CLAUDE.md overrides it. Applies to clones, venvs and build dirs too. "
            + "Reading an existing file under /tmp that you did not create is fine - "
            + "say so and ask if you genuinely need it.")
        }}'
    exit 0
  '';
in {
  programs.claude-code = {
    settings = {
      alwaysThinkingEnabled = false;
      outputStyle = "Concise";

      hooks = {
        PreToolUse = [
          {
            matcher = "Edit|Write|NotebookEdit";
            hooks = [
              {
                type = "command";
                command = "${guardProtectedBranch}";
              }
            ];
          }
          {
            matcher = "Bash|Edit|Write|NotebookEdit";
            hooks = [
              {
                type = "command";
                command = "${guardTmpScratchpad}";
              }
            ];
          }
        ];
      };
    };
  };
}
