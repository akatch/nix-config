{
  programs.atuin = {
    enable = true;
    enableZshIntegration = false;
    # https://docs.atuin.sh/configuration/config/
    settings = {
      style = "compact";
      inline_height = 10;
      show_help = false;
      show_tabs = false;
      enter_accept = true;
      keymap_mode = "vim-insert";
      history_filter = [
        "^g c"
        "^g d"
        "^g b"
        "^g st"
        "^g co .*"
      ];
    };
  };
}
