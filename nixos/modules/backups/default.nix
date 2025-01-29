{
  pkgs,
  ...
}: {
  systemd.timers."backups" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        # see man systemd.time for more examples
        OnCalendar = "*-*-* 03:00:00";
        Persistent = true;
        Unit = "backups.service";
      };
  };

  systemd.services."backups" = {
    script =
      ''
        set -e

        DATE="$(date +%F)"
        SOURCES="$HOME/pictures $HOME/code $HOME/documents $HOME/.gnupg"
        DEST="$HOME/backups"
        OFFSITE_DEST="/mnt/vault/$USER"

        ${pkgs.coreutils}/bin/mkdir -p "$DEST/$HOSTNAME"
        cd "$DEST/$HOSTNAME"

        ${pkgs.gnutar}/bin/tar --create \
            --file "$USER@$HOSTNAME-$DATE.tar.zst" \
            --use-compress-program=${pkgs.zstd}/bin/zstd \
            --exclude='*.qcow2' \
            --exclude='*.img' $SOURCES
        ${pkgs.findutils}/bin/find ./ -mindepth 1 -maxdepth 1 -ctime +1 -exec rm -rf '{}' \;

        # FIXME
        #${pkgs.rsync}/bin/rsync -az --delete ./ "$OFFSITE_DEST/"
      '';
    serviceConfig = {
      Type = "oneshot";
      User = "al";
    };
  };
}
