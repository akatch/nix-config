{
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./fonts.nix
    ./gtk.nix
    ./spotify.nix
    ./syncthing.nix
    ./zathura.nix
  ];

  home = {
    packages = with pkgs; [
      keepassxc
      pulsemixer
      signal-desktop
      zoom-us
    ];
  };
}
