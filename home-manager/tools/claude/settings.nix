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
        ];
      };
    };
  };
}
