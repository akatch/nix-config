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
          format = "<span foreground='#5faf00'>%A %e %b  %k:%M:%S </span>";
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

      "cpu_usage" = {
        enable = false;
        settings = {
          format = "cpu: %usage";
          degraded_threshold = 55;
        };
      };

      "cpu_temperature 0" = {
        enable = false;
        settings = {
          format = "%degrees °C";
          path = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input";
          separator = "no";
        };
      };
    };
  };
}
