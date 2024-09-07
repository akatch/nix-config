{
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      size = 14;
    };
    theme = {
      name = "Andromeda";
      package = pkgs.andromeda-gtk-theme;
    };
  };
}
