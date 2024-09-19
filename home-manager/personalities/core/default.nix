{
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./env.nix
    ./git.nix
    ./nixpkgs.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  home = {
    packages = with pkgs; [
      btop
      fortune
      jq
      viddy
      yq
    ];
  };
}
