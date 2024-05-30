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
      firefox
      signal-desktop
      keepassxc
      zoom-us
    ];
  };
}
