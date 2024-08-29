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
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
    ];
  };

  wayland.windowManager.sway = {
    config.gaps = {
      inner = 15;
    };
    extraConfig =
    ''
      bindswitch lid:on exec swaylock
      default_border pixel 1
    '';
  };

  programs.i3status.modules = {
    "disk /" = {
      # position is left to right
      position = 1;
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
