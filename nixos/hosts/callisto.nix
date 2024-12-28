{
  pkgs,
  ...
}: {
  imports = [
    ../modules/ddclient
    ../modules/fahstats
    ../modules/kind
    ../modules/ssh
  ];

  networking = {
    hostName = "callisto";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        6924
        9001
      ];
    };
  };

  # NO TOUCHING.
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11";
}
