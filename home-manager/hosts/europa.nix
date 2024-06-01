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
    ../personalities/cli/k9s.nix
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
