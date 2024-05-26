{
  pkgs,
  ...
}: {
  imports = [
    # TODO import these only if x86_64-linux
    ./dunst.nix
    ./i3status.nix
    ./swayidle.nix
    ./swaylock.nix
    #./sway.nix

    # always import alacritty for this personality
    ./alacritty.nix
  ];

  home = {
    packages = with pkgs; [
      firefox
      signal-desktop
      keepassxc
    ];
  };
}
