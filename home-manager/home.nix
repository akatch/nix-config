{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # core
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./env.nix
    ./git.nix
    ./tmux.nix
    #./vim.nix
    ./zsh.nix

    # k8s
    #./k9s.nix

    # linux
    ./dunst.nix
    ./i3status.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "al";
    homeDirectory = "/home/al";
    sessionPath = [
      "$HOME/code/github.com/akatch/scripts"
    ];

    packages = with pkgs; [
      # cli
      fortune
      jq
      yq

      # gui
      firefox
      signal-desktop
      keepassxc

      # laptop
      brightnessctl

      # other
      syncthing
    ];
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
