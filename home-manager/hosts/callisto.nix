{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/desktop
    ../personalities/desktop/swaywm
    ../personalities/desktop/firefox
    ../personalities/cli
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      btop
      syncthing
    ];
    # TODO
    # wayland.windowManager.sway.extraConfig = {
    #    set $main "LG Electronics LG HDR WQHD 0x0000F638"
    #    set $aux "ASUSTek COMPUTER INC VG245 K1LMQS103175"
    #    set $gapwidth 25
    #    workspace 1 output $main
    #    workspace 2 output $main
    #    workspace 3 output $aux
    #    workspace 4 output $main
    #    bindsym F9 exec playerctl -p $player play-pause
    #    bindsym F10 exec playerctl -p $player next
    #    bindsym Alt+F10 exec playerctl -p $player position 0
    #    output $main pos 0 2160
    #    output $aux pos 0 1080
    # }
    # f@h
    # weechat
    # rtorrent
    # /etc/nixos/smb-secrets
  };

  # TODO set the signal_desktop widget theme
  # These do not work
  #qt = {
  #  platformTheme.name = "gtk3";
  #  style.name = "gtk3";
  #};
}
