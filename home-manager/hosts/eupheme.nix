{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../personalities/cli
    ../personalities/core
  ];

  home = {
    username = "al";
    homeDirectory = "/home/al";
    #packages = with pkgs; [ ];
  };
}
