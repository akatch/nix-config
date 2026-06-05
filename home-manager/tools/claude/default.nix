{
  config,
  pkgs,
  ...
}: {

  imports = [
    ./commands.nix
    #./mcp-servers.nix
    ./settings.nix
  ];

  home = {
    packages = with pkgs; [
      beads
      uv
    ];

#    sessionVariables = {
#      # https://code.claude.com/docs/en/fullscreen
#      CLAUDE_CODE_NO_FLICKER = 1;
#      CLAUDE_CODE_DISABLE_MOUSE = 1;
#    };
  };

  programs.claude-code = {
    enable = true;

    context = ''
      # General

      - Begin all messages with the phrase "The Omnissiah teaches thus:"
      - Place any necessary temporary files in ./tmp instead of the global /tmp
      - Provide documentation sources for your solutions
      - DO NOT GUESS

      ## Accessing and Editing Files

      - To read files, use the Read tool instead of cat where possible
      - To find files, use the find command instead of 'ls | grep'
      - To write files, use the Write tool instead of eg 'cat', `echo`, shell redirects, etc

      ## Agent Configuration

      - Your configuration lives in ~/code/github.com/akatch/nix-config/home-manager/claude
      - Commands are set in commands.nix
      - Everything else is configured in settings.nix, 

      ## Scope Discipline

      - Only make changes that were explicitly requested. Do not add 'nice to have' options, extra config, or related improvements without asking first.
      - Never post comments, replies, or interact with GitHub/external systems on the user's behalf without explicit confirmation.
      - When addressing PR review comments, address ONLY those comments - do not make unprompted edits to other parts of the code.

      ## Investigation Guidelines

      - Do not run interactive commands (scaffolders, prompts, REPLs) in the background - they will hang. Ask the user to run these.
      - When exploration becomes meandering or a tool call runs long, stop and summarize findings instead of continuing to dig.
      - Verify branch/file paths before reading - confirm the user's actual working file (e.g., ci.yml vs ci.yaml) rather than assuming.

      ## Verification Before Edits

      - Before editing config files (values.yaml, Helm templates, VMAgent configs), state the proposed change and wait for confirmation when the user is actively debugging.
      - Use targeted edits, not replace_all, when changing variable names - replace_all often corrupts string literals.
      - Preserve existing behavior (failure passthroughs, env-var overrides, etc.) when refactoring; call out anything you're removing.

      # Git

      ## Do

      - Any new branch should have the "ab/" prefix
      - Always create a new worktree with a new branch
      - Omit the "ab/" prefix from the worktree name (but include it in the branch name)
      - Minimize incidental diffs
      - Before attempting 'git add', always:
        - Rebase with the default branch
        - Run pre-commit hooks
        - Fix any reported issues

      ## Don't

      - Never work in the main branch
      - Never include yourself as author or co-author
      - Never remove existing comments unless also removing the associated code

      # Grafana

     - Use [Grafana Conventions](~/Documents/Notes/20260323142203.md)

    '';
  };
}
