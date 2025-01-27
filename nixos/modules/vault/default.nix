{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # https://nixos.wiki/wiki/Samba
  fileSystems."/mnt/vault" = {
    device = "//xbmc/vault";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,users,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb"];
  };
}
