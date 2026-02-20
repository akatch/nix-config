{
  # podman
  # from https://nixos.wiki/wiki/Podman
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = {
      enable = true;
    };
  };
}
