{
  pkgs,
  ...
}: {
  imports = [
    ../modules/backups
    ../modules/fahstats
    ../modules/podman
    ../modules/protonvpn
    ../modules/sound
    ../modules/ssh
    ../modules/vault
  ];

  hardware.bluetooth.enable = true;
  programs.sway.enable = true;

  services = {
    printing.enable = true;
    tzupdate.enable = true;
  };

  networking = {
    hostName = "europa";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        6924
        8080
      ];
    };
    wireless = {
      enable = true;
      userControlled = true;
      secretsFile = "/etc/nixos/wireless.env";
      networks = {
        WifiIsComing.pskRaw = "ext:PSK_HOME";
        PfizerNet_5G.pskRaw = "ext:PSK_HOTSPOT";
        STARLINK.pskRaw = "ext:PSK_BE";
      };
    };
  };

  # Scrape for books to add to Calibre
  systemd.timers."books" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "15m";
        OnUnitActiveSec = "15m";
        Unit = "books.service";
      };
  };
  systemd.services."books" = {
    script =
      ''
        ${pkgs.findutils}/bin/find $HOME/torrents/books/ -iregex '.*.[epub|mobi|pdf]' -mmin -15 -exec cp -f '{}' $HOME/books/new/ \;
      '';
    serviceConfig = {
      Type = "oneshot";
      User = "al";
    };
  };

  # NO TOUCHING.
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
