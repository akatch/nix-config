{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "monospace 18";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "true";
        indicate_hidden = true;
        alignment = "left";
        show_age_threshold = 600;
        word_wrap = true;
        ignore_newline = false;
        width = 400;
        origin = "top-right";
        offset = "0x0";
        shrink = false;
        transparency = 0;
        idle_threshold = 30;
        follow = "none";
        monitor = 1;
        sticky_history = true;
        history_length = 20;
        show_indicators = false;
        line_height = 0;
        padding = 20;
        horizontal_padding = 20;
        separator_color = "frame";
        separator_height = 1;
        dmenu = "dmenu -p dunst:";
        browser = "firefox -new-tab";
        min_icon_size = 50;
        max_icon_size = 125;
        icon_position = "left";
        #icon_path = /usr/share/icons/Adwaita/scalable/status/:/usr/share/icons/Adwaita/scalable/actions/;
        frame_width = 1;
        frame_color = "#3a3a3a";
        progress_bar = true;
      };

      slack = {
        background = "#121212";
        foreground = "#5f8700";
        timeout = 30;
        summary = "New message *";
        new_icon = "chat-message-new-symbolic";
      };

      urgency_low = {
        background = "#121212";
        foreground = "#767676";
        timeout = 30;
        icon = "dialog-information-symbolic";
      };

      urgency_normal = {
        background = "#121212";
        foreground = "#5f8700";
        timeout = 30;
        icon = "dialog-information-symbolic";
      };

      urgency_critical = {
        background = "#121212";
        foreground = "#ffaf00";
        timeout = 60;
        icon = "dialog-error-symbolic";
      };
    };
  };
}
