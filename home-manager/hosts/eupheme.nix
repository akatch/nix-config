{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../platforms/linux
    ../personalities/cli
    ../personalities/core
  ];

  home = {
    username = "al";
    #packages = with pkgs; [ ];
  };
}
