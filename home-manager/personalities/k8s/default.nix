{
  pkgs,
  ...
}: {
  imports = [
    ./k9s.nix
  ];
  home = {
    packages = with pkgs; [
      kubernetes-helm
      kubectl
    ];
  };
}
