{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/cli
    ../personalities/core
    ../personalities/desktop
    ../personalities/filesharing
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
      calibre
      weechat
    ];
  };

  wayland.windowManager.sway = {
    config.gaps = {
      inner = 15;
    };
    extraConfig =
    ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      bindswitch lid:on exec swaylock
      bindswitch lid:off output eDP-1 enable
      bindsym Mod4+z output DP-2 enable; output DP-2 pos 0 2160; output eDP-1 disable; workspace 1 output DP-2; workspace 2 output DP-2
      bindsym Mod4+Shift+z output eDP-1 enable; workspace 1 output eDP-1; workspace 2 output eDP-1
      default_border pixel 1
    '';
  };

  programs.i3status.modules = {
    "read_file fahstats" = {
      position = 0;
      settings = {
        path = "~/.cache/fahstats";
        format = "<span foreground='#5f8700'>f@h: %content</span>";
      };
    };

    "disk /" = {
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

    "cpu_usage" = {
      position = 4;
      settings = {
        format = "cpu: %usage ";
        degraded_threshold = 55;
        separator = "no";
      };
    };

    "cpu_temperature 0" = {
      position = 5;
      enable = false;
      settings = {
        format = "%degrees °C ";
        path = "/sys/devices/platform/coretemp.0/hwmon/hwmon6/temp1_input";
        separator = "no";
      };
    };

    "load" = {
      position = 6;
      settings = {
        format = "%1min   %5min   %15min";
      };
    };

    "battery 0" = {
      position = 7;
      settings = {
        format = "%status %percentage";
        status_chr = "⚡";
        status_bat = "";
        status_full = "";
        last_full_capacity = true;
        integer_battery_capacity = true;
        low_threshold = 19;
        threshold_type = "percent";
      };
    };

    "time" = {
      position = 8;
      settings = {
        format = "<span foreground='#5faf00'>%A %e %B  %k:%M:%S </span>";
        separator = "no";
      };
    };

    "tztime utc" = {
      position = 9;
      settings = {
        format = "<span foreground='#5faf00'>%k:%M</span> ";
        timezone = "Etc/Utc";
      };
    };
  };
}
