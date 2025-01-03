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
      jq
      killall
      openssl
      shellcheck
      viddy
      yq
    ];
  };
}
