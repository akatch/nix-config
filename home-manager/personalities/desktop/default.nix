{
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./spotify.nix
    ./zathura.nix
  ];

  home = {
    packages = with pkgs; [
      signal-desktop
      keepassxc
      zoom-us
    ];
  };
}
