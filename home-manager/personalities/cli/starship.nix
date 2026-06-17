{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = builtins.concatStringsSep "" [
        "$kubernetes"
        "\${custom.hostname}"
        "$directory"
        "\${custom.repo_name}"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$character"
      ];
      kubernetes = {
        format = "[$context](cyan) ";
        disabled = false;
      };
      username = {
        disabled = true;
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "32";
        # ︎ forces character to display as unicode glyph not emoji;
        # FIXME this ^ doesn't actually work... at least not in zsh;
        read_only = "🔒︎";
      };
      # Built-in hostname always shows; we replace it with a custom module
      # that hides itself when a kubernetes context is active so the k8s
      # cluster name takes its place per the prompt spec.
      hostname = {
        disabled = true;
      };
      custom.hostname = {
        command = "hostname -s";
        when = "! kubectl config current-context >/dev/null 2>&1";
        format = "[$output](green) ";
        shell = [ "sh" "--noprofile" "--norc" ];
      };
      character = {
        success_symbol = "[»](bold green) ";
        error_symbol = "[✗](bold red) ";
        vicmd_symbol = "[«](bold green) ";
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "70";
      };
      custom.repo_name = {
        command = "basename $(dirname $(git rev-parse --path-format=absolute --git-common-dir)) | sed 's/\\.git$//'";
        when = "git rev-parse --is-inside-work-tree";
        format = "on [$output]($style) ";
        style = "70";
      };
      nix_shell = {
        format = "[$symbol]($style)";
        symbol = "❄️ ";
        impure_msg = "";
        pure_msg = "";
        unknown_msg = "";
      };
      cmd_duration = {
        style = "yellow";
      };
    };
  };
}
