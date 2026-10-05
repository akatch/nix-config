{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;

      # Whole-line zsh glob patterns, not regex
      ignorePatterns = [
        "g c"
        "g d"
        "g b"
        "g st"
        "g co *"
        "z"
        "zo"
      ];
    };

    completionInit =
      ''
        setopt autocd extendedglob notify
        unsetopt beep nomatch
        zstyle ':completion:*' rehash true
        autoload -Uz compinit
        compinit
      '';

    initContent =
      ''
      setopt INC_APPEND_HISTORY

      # HISTORY_IGNORE only filters the history file; this filters the
      # in-memory list too, so CTRL-R can't surface it mid-session.
      zshaddhistory() {
        emulate -L zsh
        setopt extended_glob
        [[ ''${1%%$'\n'} != ''${~HISTORY_IGNORE} ]]
      }

      export LESS_TERMCAP_mb=$'\e[38;5;24m'
      export LESS_TERMCAP_md=$'\e[01;38;5;28m'
      export LESS_TERMCAP_so=$'\e[38;5;214m'
      export LESS_TERMCAP_us=$'\e[04;38;5;34m'
      export LESS_TERMCAP_ue=$'\e[0m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_se=$'\e[0m'
      eval "$(direnv-instant hook bash)"
      fortune
      '';

      siteFunctions = {
        h = ''
          history | grep --color=auto $1
        '';

        ghclone = ''
          git clone git@github.com:$1 ~/code/github.com/$1
        '';
      };

    syntaxHighlighting = {
      enable = true;
    };
  };
}
