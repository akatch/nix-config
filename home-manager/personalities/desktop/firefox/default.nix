{
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";
          "browser.search.openintab" = true;
          "browser.urlbar.openintab" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "font.minimum-size.x-western" = 16;
        };
        search = {
          force = true;
          default = "DuckDuckGo";
          order = [
            "DuckDuckGo"
            "Wikipedia"
          ];
        };
      };
    };
  };
}
