{
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 16;
    };
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
