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
      jq
      killall
      openssl
      shellcheck
      silver-searcher
      unzip
      viddy
      yq
    ];
  };
}
