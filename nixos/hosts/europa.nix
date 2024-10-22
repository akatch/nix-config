{
  imports = [
    ../modules/ssh
    ../modules/fahstats
  ];

  networking = {
    hostName = "europa";
    wireless = {
      environmentFile = "/etc/nixos/wireless.env";
      networks = {
        WifiIsComing.psk = "@PSK_HOME@";
      };
    };
  };

  # NO TOUCHING.
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
