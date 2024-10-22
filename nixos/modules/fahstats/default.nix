{
  pkgs,
  ...
}: {
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
