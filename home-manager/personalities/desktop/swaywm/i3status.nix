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
  };
}
