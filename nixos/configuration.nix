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

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "kvm-amd" "kvm-intel" ];
  };

  networking.wireless = {
    enable = true;
    userControlled = true;
  };

  programs.sway.enable = true;
  programs.zsh.enable = true;

  hardware.bluetooth.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    locate = {
      enable = true;
      package = pkgs.mlocate;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    
    printing.enable = true;
    tzupdate.enable = true;
  };

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
  ];
}
