{
  pkgs,
  inputs,
  ...
}:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };
in
{
  imports = [
    ./bash.nix
    ./direnv.nix
    ./env.nix
    ./git.nix
    ./gpg.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  home = {
    packages = with pkgs; [
      btop
      dig
      fortune
      gnumake
      jq
      killall
      unixtools.netstat
      lsof
      openssl
      shellcheck
      pkgs-stable.silver-searcher
      unzip
      viddy
      whois
      yq
    ];
  };
}
