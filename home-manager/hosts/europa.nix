{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/cli
    ../personalities/core
    ../personalities/desktop
    ../personalities/filesharing
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
      calibre
      weechat
    ];
  };

  wayland.windowManager.sway = {
    config.gaps = {
      inner = 15;
    };
    extraConfig =
    ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      bindswitch lid:on exec swaylock
      bindswitch lid:off output eDP-1 enable
      bindsym Mod4+z output DP-2 enable; output DP-2 pos 0 2160; output eDP-1 disable; workspace 1 output DP-2; workspace 2 output DP-2
      bindsym Mod4+Shift+z output eDP-1 enable; workspace 1 output eDP-1; workspace 2 output eDP-1
      default_border pixel 1
    '';
  };
}
