{
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./env.nix
    ./git.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  home = {
    packages = with pkgs; [
      btop
      dig
      fortune
      fzf
      jq
      killall
      openssl
      shellcheck
      silver-searcher
      viddy
      yq
    ];
  };
}
