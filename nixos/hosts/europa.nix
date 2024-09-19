{
  networking = {
    hostName = "europa";
    wireless = {
      environmentFile = "/etc/nixos/wireless.env";
      networks = {
        WifiIsComing.psk = "@PSK_HOME@";
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # NO TOUCHING.
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
