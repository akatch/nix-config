#
# /etc/nixos/configuration.nix
# configuration.nix(5) or nixos-help or https://search.nixos.org/options
#

{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  networking.wireless.enable = true;

  programs.sway.enable = true;
  programs.zsh.enable = true;

  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.localtimed.enable = true;

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  # podman
  # from https://nixos.wiki/wiki/Podman
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = {
      enable = true;
    };
  };

  users.users.al = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "mlocate" "qemu-libvirtd" "libvirtd" ];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  environment.systemPackages = with pkgs; [
    vim
    mlocate
    cifs-utils
  ];

  # https://nixos.wiki/wiki/Samba
  fileSystems."/mnt/vault" = {
    device = "//xbmc/vault";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      terminus_font
    ];
    fontconfig = {
      # Can this be set per-user?
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Terminus" ];
      };
    };
  };
}
