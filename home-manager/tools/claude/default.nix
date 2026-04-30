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

    sessionVariables = {
      # https://code.claude.com/docs/en/fullscreen
      CLAUDE_CODE_NO_FLICKER = 1;
      CLAUDE_CODE_DISABLE_MOUSE = 1;
    };
  };

  programs.claude-code = {
    enable = true;

    context = ''
      # General
      - Begin all messages with the phrase "The Omnissiah teaches thus:"
      - Place any necessary temporary files in ./tmp instead of the global /tmp
      - Whenever possible, provide documentation sources for your solutions
      - If you are unsure of the correct answer, say so instead of guessing
      - To read files, use the Read tool instead of cat where possible
      - To find files, use the find command instead of 'ls | grep'

      # Agent Configuration
      - Your configuration lives in ~/code/github.com/akatch/nix-config/home-manager/claude
      - Commands are set in commands.nix
      - Everything else is configured in settings.nix, 

      # Git
      - Any new branch should have the "ab/" prefix
      - Never work in the main branch
      - Always create a new worktree with a new branch

      # Grafana
     - Use [Grafana Conventions](~/Documents/Notes/20260323142203.md)
     - When editing a dashboard, always pipe the resulting JSON model into `pbcopy`
     - Increment the "version" metadata tag with each edit
     - Include a brief description of your changes in the "message" field

    '';
  };
}
