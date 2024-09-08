{
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./firefox
    ./fonts.nix
    ./gtk.nix
    ./spotify.nix
    ./swaywm
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
