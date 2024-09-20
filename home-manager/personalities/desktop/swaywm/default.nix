{
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./i3status.nix
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  home = {
    packages = with pkgs; [
      sway-contrib.grimshot
    ];
  };
}
