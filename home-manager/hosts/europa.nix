{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/desktop
    ../personalities/cli
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
      prusa-slicer
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
      bindsym Mod4+z output DP-2 enable; output eDP-1 disable; workspace 1 output DP-2; workspace 2 output DP-2
      default_border pixel 1
    '';
  };

  programs.i3status.modules = {
    "disk /home" = {
      # position is left to right
      position = 1;
      settings = {
        format = "/home: %used (%percentage_used)";
      };
    };

    "disk /" = {
      position = 0;
      settings = {
        format = "/: %used (%percentage_used)";
      };
    };

    "memory" = {
      position = 2;
      settings = {
        format = "ram: %used (%percentage_used)";
        threshold_degraded = "20%";
        threshold_critical = "10%";
      };
    };

    "load" = {
      position = 3;
      settings = {
        format = "%1min   %5min   %15min";
      };
    };

    "battery 0" = {
      position = 4;
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

    "tztime cst" = {
      position = 5;
      settings = {
        format = "<span foreground='#5faf00'>%A %e %B  %k:%M:%S </span>";
        timezone = "US/Central";
        separator = "no";
      };
    };

    "tztime utc" = {
      position = 6;
      settings = {
        format = "<span foreground='#5faf00'>%k:%M</span> ";
        timezone = "Etc/Utc";
      };
    };
  };
}
