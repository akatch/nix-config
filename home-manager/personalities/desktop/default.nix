{
  pkgs,
  ...
}: {
  imports = [
    ../../shells/alacritty
    ./firefox
    ./fonts.nix
    ./gtk.nix
    ./spotify.nix
    ./swaywm
    ./zathura.nix
  ];

  home = {
    packages = with pkgs; [
      keepassxc
      prusa-slicer
      pulsemixer
      signal-desktop
      zoom-us
    ];
  };
}
