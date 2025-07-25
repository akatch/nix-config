{
  config,
  lib,
  ...
}: {
  wayland.windowManager.sway =
    let
      background = "#080808";
      foreground = "#767676";
      darkgray = "#1c1c1c";

      black = "#121212";
      red = "#d7005f";
      green = "#00af00";
      yellow = "#ffaf00";
      blue = "#0000ff";
      magenta = "#8700ff";
      cyan = "#00afaf";
      silver = "#444444";

      gray = "#303030";
      brightred = "#d75f5f";
      brightgreen = "#5f8700";
      brightyellow = "#ffd700";
      brightblue = "#005fff";
      brightmagenta = "#875fff";
      brightcyan = "#01d7af";
      white = "#ffffff";
    in
  {
    enable = true;
    config = {
      bars = [
      {
        fonts = {
          size = 18.0;
        };
        position = "top";
        workspaceButtons = false;
        extraConfig =
          ''
            separator_symbol " | "
          '';
        statusCommand = "i3status";

        colors = {
            separator = "${silver}";
            statusline = "${brightgreen}";
            background = "${background}";
        };
      }
    ];
      colors = {
          focused = {
            border = "${background}";
            background = "${background}";
            text = "${foreground}";
            indicator = "${brightgreen}";
            childBorder = "${brightgreen}";
          };
          focusedInactive = {
            border = "${background}";
            background = "${background}";
            text = "${background}";
            indicator = "${gray}";
            childBorder = "${gray}";
          };
          unfocused = {
            border = "${background}";
            background = "${background}";
            text = "${background}";
            indicator = "${gray}";
            childBorder ="${gray}";
          };
          urgent = {
            border = "${background}";
            background = "${background}";
            text = "${brightgreen}";
            indicator = "${yellow}";
            childBorder = "${yellow}";
          };
          placeholder = {
            border = "${background}";
            background = "${background}";
            text = "${foreground}";
            indicator = "${silver}";
            childBorder = "${silver}";
          };
          background = "${background}";
      };
      defaultWorkspace = "workspace number 1";
      floating = {
        titlebar = false;
      };
      focus = {
        followMouse = false;
        wrapping = "workspace";
      };
      fonts = {
        names = [ "pango:monospace" ];
        size = 18.0;
      };
      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };
      input = {
        "type:keyboard" = {
          xkb_options = "ctrl:swapcaps";
          xkb_numlock = "enable";
          repeat_delay = "300";
          repeat_rate = "30";
        };
        "type:touchpad" = {
          # TODO 3-finger swipe to change workspace
          tap = "enabled";
        };
      };
      # https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.sway.config.keybindings
      keybindings =
      let
          mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault
      {
        "${mod}+Shift+w" = "exec 'firefox'";
        "${mod}+n" = "exec 'dunstctl close-all'";
        "${mod}+m" = "exec alacritty msg create-window -e pulsemixer";
        "Ctrl+space" = "workspace 1";
        "Alt+space" = "workspace 2";
        "Ctrl+Shift+l" = "exec swaylock";

        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";

        "XF86AudioPlay" = "exec playerctl -p spotify play-pause";
        "XF86AudioNext" = "exec playerctl -p spotify next";
        "XF86AudioPrev" = "exec playerctl -p spotify position 0";
        "XF86MonBrightnessDown" = " exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
      };
      menu = "dmenu-wl_run -i -sb '${darkgray}' -sf '${brightgreen}' -nb '${background}' -nf '${foreground}' -fn 'monospace 18' -h 30";
      modifier = "Mod4";
      output = {
        "*" = {
          background = "${darkgray} solid_color";
        };
      };
      startup = [
        { command = "eval $(ssh-agent)"; }
        { command = "tmux new -s code -c $HOME/code/github.com/akatch -d"; }
        { command = "tmux new -s al -d"; }
        { command = "alacritty"; }
        { command = "firefox"; }
        { command = "calibre"; }
        { command = "swayidle -w timeout 1800 'swaylock -f -c 000000' timeout 3600 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' before-sleep 'swaylock -f -c 000000'"; }
      ];
      terminal = "alacritty";
    };
  };
}
