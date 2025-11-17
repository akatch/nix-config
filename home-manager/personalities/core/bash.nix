{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
    ];

    shellOptions = [
      "autocd"
      "cmdhist"
      "histappend"
      "hostcomplete"
      "nocaseglob"
    ];

    initContent =
      ''
      # history search like zsh
      bind '"\e[A": history-search-backward'
      bind '"\eOA": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\eOB": history-search-forward'

      # tabcomplete like zsh
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'

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

      export PS1="\[\e[38;05;237m\]\h \[\e[38;05;70m\]\W \[\e[38;05;237m\]\$(git branch --show-current 2> /dev/null) \[\e[38;05;70m\]\$\[\e[00m\] "
      fortune
      '';
  };
}
