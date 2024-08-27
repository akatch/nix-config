{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/desktop
    ../personalities/desktop/swaywm
    ../personalities/desktop/firefox
    ../personalities/cli
    ../personalities/cli/rtorrent.nix
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      weechat
    ];
  };

  wayland.windowManager.sway =
  let
    main = "LG Electronics LG HDR WQHD 0x0000F638";
    aux = "ASUSTek COMPUTER INC VG245 K1LMQS103175";
    player = "spotify";
  in
  {
    config = {
      gaps = {
        inner = 25;
      };
      output = {
        "${main}" = {
          pos = "0 2160";
        };
        "${aux}" = {
          pos = "0 1080";
        };
      };
    };
    extraConfig =
    ''
       bindsym F9 exec playerctl -p ${player} play-pause
       bindsym F10 exec playerctl -p ${player} next
       bindsym Alt+F10 exec playerctl -p ${player} position 0
       default_border pixel 1
       workspace 1 output ${main}
       workspace 2 output ${main}
       workspace 3 output ${aux}
       workspace 4 output ${main}
    '';
  };

  programs.i3status = {
    modules = {
      "read_file fahstats" = {
        position = 0;
        settings = {
          path = "~/.cache/fahstats";
          format = "<span foreground='#5f8700'>f@h: %content</span>";
        };
      };

      "disk /" = {
        # position is left to right
        position = 1;
        settings = {
          format = "/: %used (%percentage_used)";
        };
      };

      "disk /home" = {
        # position is left to right
        position = 2;
        settings = {
          format = "/home: %used (%percentage_used)";
        };
      };

      "memory" = {
        position = 3;
        settings = {
          format = "ram: %used (%percentage_used)";
          threshold_degraded = "20%";
          threshold_critical = "10%";
        };
      };

      "cpu_temperature 0" = {
        position = 5;
        settings = {
          format = "%degrees °C ";
          path = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input";
          separator = "no";
        };
      };

      "cpu_usage" = {
        position = 4;
        settings = {
          format = "cpu: %usage ";
          degraded_threshold = 55;
          separator = "no";
        };
      };

      "load" = {
        position = 6;
        settings = {
          format = "%1min   %5min   %15min";
        };
      };

      "tztime cst" = {
        position = 7;
        settings = {
          format = "<span foreground='#5faf00'>%A %e %B  %k:%M:%S </span>";
          timezone = "US/Central";
          separator = "no";
        };
      };

      "tztime utc" = {
        position = 8;
        settings = {
          format = "<span foreground='#5faf00'>%k:%M</span> ";
          timezone = "Etc/Utc";
        };
      };
    };
  };
  # TODO set the signal_desktop widget theme
  # These do not work
  #qt = {
  #  platformTheme.name = "gtk3";
  #  style.name = "gtk3";
  #};
}
