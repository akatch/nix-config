{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/core
    ../personalities/desktop
    ../personalities/desktop/swaywm
    ../personalities/desktop/firefox
    ../personalities/cli
    ../personalities/cli/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
      syncthing
    ];
  };
}
