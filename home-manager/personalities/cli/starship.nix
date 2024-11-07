{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      kubernetes = {
        format = "[$context:$namespace](cyan) ";
        disabled = false;
      };
      username = {
        style_user = "white";
        style_root = "red bold";
        format = "[$user]($style)[@](blue bold)";
        disabled = true;
      };
      directory = {
        format = "[$path]($style) [$read_only]($read_only_style) ";
        style = "32";
        # \uFE0E forces character to display as unicode glyph not emoji;
        # FIXME this ^ doesn't actually work... at least not in zsh;
        read_only = "🔒\uFE0E";
      };
      hostname = {
        ssh_only = false;
        format =  "[$hostname](green) ";
        disabled = false;
      };
      character = {
        success_symbol = "[»](bold green) ";
        error_symbol = "[✗](bold red) ";
        vicmd_symbol = "[«](bold green) ";
      };
      git_branch = {
        style = "70";
      };
      cmd_duration = {
        style = "yellow";
      };
    };
  };
}
