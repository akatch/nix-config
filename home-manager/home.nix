{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    #./k9s.nix
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
