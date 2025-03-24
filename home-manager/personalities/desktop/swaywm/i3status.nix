{
  programs.i3status = {
    enable = true;
    enableDefault = false;
    general = {
      interval = 1;
      markup = "pango";
      color_good = "#4e4e4e";
      color_degraded = "#ffd700";
      color_bad = "#d75f5f";
    };
    modules = {
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
  };
}
