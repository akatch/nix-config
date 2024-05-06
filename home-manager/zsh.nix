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
      # FIXME -G is macos, --color is linux
      "l" = "ls -lhG";
      "lah" = "ls -lahG";
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
      export LESS_TERMCAP_mb=$'\e[38;5;24m'
      export LESS_TERMCAP_md=$'\e[01;38;5;28m'
      export LESS_TERMCAP_so=$'\e[38;5;214m'
      export LESS_TERMCAP_us=$'\e[04;38;5;34m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      '';
  };
}
