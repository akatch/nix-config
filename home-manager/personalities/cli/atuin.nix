{
  programs.atuin = {
    enable = true;
    #enableZshIntegration = true;
    # https://docs.atuin.sh/configuration/config/
    settings = {
      style = "compact";
      inline_height = 10;
      show_help = false;
      show_tabs = false;
      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };
}
