{
  services.swayidle = {
    enable = true;
    extraArgs = ["-w"];
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 1800;
        command = "swaylock";
      }{
        timeout = 3600;
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
    ];
  };
}
