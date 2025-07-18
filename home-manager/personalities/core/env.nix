{
  home = {
    sessionPath = [
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      GREP_COLORS = "mt=38;5;214:sl=:cx=:fn=38;5;236:ln=32:bn=32:se = '38;5;233'";
      GREP_COLOR = "38;5;214";
      EDITOR = "vim";
      JQ_COLORS = "1;30:0;37:0;37:0;37:0;32:1;37:1;37";
      LANG = "en_US.UTF-8";
      LESS = "-j.5 -R -F -X";
      LESSCHARSET = "utf-8";
      MANWIDTH = "60";
      MANROFFOPT = "-c";
      NIX_CONFIG = "experimental-features = nix-command flakes";
      QUOTING_STYLE = "literal";
      VISUAL = "$EDITOR";
      ZETTEL_DIR = "$HOME/sync/zettelkasten";
    };

    shellAliases = {
      "drs" = "darwin-rebuild switch --flake .#$(hostname)";
      "e" = "vim";
      "g" = "git";
      "gr" = "grep -rs --exclude-dir=.git";
      "hms" = "home-manager switch --flake .#$(whoami)@$(hostname)";
      "l" = "ls -lhG";
      "lah" = "ls -lahG";
      "nfu" = "nix flake update";
      "nrs" = "sudo nixos-rebuild switch --flake .#$(hostname)";
      "se" = "sudo -e";
      "ta" = "tmux attach -t";
      "z" = "vim -c ZettelNew";
      "zo" = "vim -c ZettelOpen";
    };
  };
}
