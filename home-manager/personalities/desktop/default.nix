{
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./i3status.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  home = {
    packages = with pkgs; [
      firefox
      signal-desktop
      keepassxc
    ];
  };
}
