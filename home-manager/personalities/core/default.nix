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
      fortune
      jq
      yq
    ];
  };
}
