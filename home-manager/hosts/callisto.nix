{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/cli
    ../personalities/filesharing
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      pciutils
      nvtopPackages.full
      vagrant
      weechat
    ];
  };
}
