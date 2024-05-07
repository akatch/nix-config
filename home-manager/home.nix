{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # cli
    ./git.nix
    ./tmux.nix
    #./vim.nix
    ./zsh.nix
    ./direnv.nix

    # k8s
    #./k9s.nix

    # gui
    ./alacritty.nix
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
    sessionVariables = {
      GPG_TTY = "$(tty)";
      GREP_COLORS = "mt=38;5;214:sl=:cx=:fn=38;5;236:ln=32:bn=32:se = '38;5;233'";
      GREP_COLOR = "38;5;214";
      EDITOR = "vim";
      JQ_COLORS = "1;30:0;37:0;37:0;37:0;32:1;37:1;37";
      LANG = "en_US.UTF-8";
      LESS = "-j.5 -R -F -X";
      LESSCHARSET = "utf-8";
      MANWIDTH = "60";
      MANROFFOPT = "-c";
      NIX_CONFIG = "experimental-features = nix-command flakes";
      QUOTING_STYLE = "literal";
      VISUAL = "$EDITOR";
    };
    packages = with pkgs; [
      # cli
      jq
      yq
      fortune
      #terminus_font

      # gui
      signal-desktop
      firefox
      syncthing

      # laptop
      brightnessctl
    ];
  };

  programs.home-manager.enable = true;
  #programs.fzf.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
