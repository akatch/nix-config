{
  pkgs,
  ...
}: {
  imports = [
    ../modules/amdgpu
    ../modules/backups
    ../modules/ddclient
    ../modules/podman
    ../modules/ssh
    ../modules/vault
  ];

  services.tailscale.enable = true;
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
