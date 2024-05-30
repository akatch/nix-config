{
  home = {
    sessionPath = [
      "$HOME/code/github.com/akatch/scripts"
    ];

    sessionVariables = {
      GPG_TTY = "$(tty)";
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
    };

    shellAliases = {
      "e" = "vim -p";
      "g" = "git";
      "gr" = "grep -rs";
      "hms" = "home-manager switch --flake .#$(whoami)@$(hostname)";
      "l" = "ls -lhG";
      "lah" = "ls -lahG";
      "nrs" = "sudo nixos-rebuild switch";
      "se" = "sudo -e";
      "ta" = "tmux attach -t";
    };
  };
}
