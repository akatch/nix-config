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
    ../personalities/k8s
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    packages = with pkgs; [
      brightnessctl
      syncthing
    ];
  };

  # TODO set the signal_desktop widget theme
  # These do not work
  #qt = {
  #  platformTheme.name = "gtk3";
  #  style.name = "gtk3";
  #};
}
