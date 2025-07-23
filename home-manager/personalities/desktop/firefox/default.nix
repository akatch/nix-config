{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.newtabpage.pinned" = "";
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";
          "browser.search.openintab" = true;
          "browser.tabs.hoverPreview.enabled" = false;
          "browser.topsites.contile.enabled" = false;
          "browser.urlbar.openintab" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "extensions.pocket.enabled" = false;
          "extensions.webextensions.restrictedDomains" = "";
          "font.minimum-size.x-western" = 18;
          "app.shield.optoutstudies.enabled" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
        };
        search = {
          force = true;
          default = "ddg";
          order = [
            "DuckDuckGo"
            "Wikipedia"
          ];
        };
      };
    };
  };
}
