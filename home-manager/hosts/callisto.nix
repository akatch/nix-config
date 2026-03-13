{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../platforms/linux
    ../personalities/core
    ../personalities/cli
    ../personalities/k8s
    ../tools/rtorrent
    ../tools/syncthing
  ];

  home = {
    username = "al";
    packages = with pkgs; [
      pciutils
      nvtopPackages.full
      vagrant
      weechat
    ];
  };
}
