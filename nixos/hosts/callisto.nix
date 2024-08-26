{
  networking.hostName = "callisto";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      6924
      9001
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
