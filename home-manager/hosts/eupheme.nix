{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/cli
    ../personalities/core
  ];

  home = {
    username = "al";
    homeDirectory = "/home/${config.home.username}";
    #packages = with pkgs; [ ];
  };
}
