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

  programs.zsh.enable = true;

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
  };

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
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
