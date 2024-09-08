{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      terminus_font
    ];
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Terminus" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
