{
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      pinentry
    ];
  };
}
