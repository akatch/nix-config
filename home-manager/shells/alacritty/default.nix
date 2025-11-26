{
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 18;
      };
      keyboard.bindings = [
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }{
          key = "V";
          mods = "Control|Shift";
          action = "PasteSelection";
        }
      ];
      colors = {
        primary = {
          background = "#080808";
          foreground = "#bbbbbb";
        };
        selection = {
          background = "#303030";
          foreground = "#00ff00";
        };
        normal = {
          blue = "#0000ff";
          cyan = "#00afaf";
          green = "#00af00";
          magenta = "#8700ff";
          red = "#d7005f";
          white = "#444444";
          yellow = "#ffaf00";
        };
        bright = {
          black = "#303030";
          blue = "#005fff";
          cyan = "#00d7af";
          green = "#00ff00";
          magenta = "#875fff";
          red = "#d75f5f";
          yellow = "#ffd700";
        };
        footer_bar = {
          background = "#767676";
          foreground = "#d75f5f";
        };
        hints = {
          end = {
            background = "#080808";
            foreground = "#767676";
          };
          start = {
            background = "#080808";
            foreground = "#ffd700";
          };
        };
      };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
