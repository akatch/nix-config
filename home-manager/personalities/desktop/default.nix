{
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./zathura.nix
  ];

  home = {
    packages = with pkgs; [
      firefox
      signal-desktop
      spotify-client
      keepassxc
      zoom-us
    ];
  };
}
