{
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ../../../shells/foot
    ./i3status.nix
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  home = {
    packages = with pkgs; [
      sway-contrib.grimshot
      dmenu-wayland
    ];
  };
}
