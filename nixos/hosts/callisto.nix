{
  pkgs,
  ...
}: {
  networking.hostName = "callisto";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      6924
      9001
    ];
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
}
