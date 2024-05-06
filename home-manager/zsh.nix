{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    historySubstringSearch.enable = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    completionInit =
      ''
        setopt autocd extendedglob notify
        unsetopt beep nomatch
        zstyle ':completion:*' rehash true
        autoload -Uz compinit
        compinit
      '';

    shellAliases = {
      "e" = "vim -p";
      "g" = "git";
      "gr" = "grep -r";
      "hms" = "home-manager switch --flake .#$(whoami)@$(hostname)";
      "l" = "ls -lhG";
      "lah" = "ls -lahG";
      "nrs" = "sudo nixos-rebuild switch";
      "se" = "sudo -e";
      "ta" = "tmux attach -t";
    };

    shellGlobalAliases = {
      ".." = "../";
      "..." = "../../";
      "...." = "../../../";
    };

    initExtra =
      ''
      h() {
          history | grep --color=auto $1
      }

      ghclone() {
          git clone git@github.com:$1 ~/code/github.com/$1
      }

      export LESS_TERMCAP_mb=$'\e[38;5;24m'
      export LESS_TERMCAP_md=$'\e[01;38;5;28m'
      export LESS_TERMCAP_so=$'\e[38;5;214m'
      export LESS_TERMCAP_us=$'\e[04;38;5;34m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      export PS1="%F{237}%m%f %F{%(?.64.208)}%~%f %F{%(?.64.208)}%#%f "
      fortune
      '';
  };
}
