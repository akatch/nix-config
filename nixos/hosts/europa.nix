{
  pkgs,
  ...
}: {
  networking = {
    hostName = "europa";
    wireless = {
      environmentFile = "/etc/nixos/wireless.env";
      networks = {
        WifiIsComing.psk = "@PSK_HOME@";
      };
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  systemd.timers."fahstats" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "15m";
        OnUnitActiveSec = "15m";
        Unit = "fahstats.service";
      };
  };

  systemd.services."fahstats" = {
    script =
      ''
        printf "%'d (%'d)" $(${pkgs.curl}/bin/curl -sqL api.foldingathome.org/user/raktajino | ${pkgs.jq}/bin/jq -r '"\(.score) \(.rank)"') > $HOME/.cache/fahstats
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
