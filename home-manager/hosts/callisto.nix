{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/cli
    ../personalities/k8s
    ../tools/rtorrent
    ../tools/syncthing
  ];

  home = {
    username = "al";
    homeDirectory = "/home/${config.home.username}";
    packages = with pkgs; [
      pciutils
      nvtopPackages.full
      vagrant
      weechat
    ];
  };
}
