{
  pkgs,
  ...
}: {
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
      silver-searcher
      unzip
      viddy
      whois
      yq
    ];
  };
}
