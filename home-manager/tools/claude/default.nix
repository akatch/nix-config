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
      - To read files, use the Read tool instead of cat where possible
      - To find files, use the find command instead of 'ls | grep'
      - To write files, use the Write tool instead of eg 'cat', `echo`, etc

      # Agent Configuration

      - Your configuration lives in ~/code/github.com/akatch/nix-config/home-manager/claude
      - Commands are set in commands.nix
      - Everything else is configured in settings.nix, 

      # Git

      ## Do

      - Any new branch should have the "ab/" prefix
      - Always create a new worktree with a new branch
      - Omit the "ab/" prefix from the worktree name (but include it in the branch name)
      - Before attempting 'git add', always:
        - Rebase with the default branch
        - Run pre-commit hooks
        - Fix any reported issues

      ## Don't

      - Never work in the main branch
      - Never include yourself as author or co-author

      # Grafana

     - Use [Grafana Conventions](~/Documents/Notes/20260323142203.md)

    '';
  };
}
