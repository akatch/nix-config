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
      keepassxc
    ];
  };
}
