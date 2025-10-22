# documentation: https://nix-community.github.io/home-manager/options.xhtml#opt-targets.darwin.currentHostDefaults
{
  pkgs,
  config,
  ...
}: {
  home = {
    username = "abowles";
    homeDirectory = "/Users/${config.home.username}";
  };

  programs.alacritty.settings.font.normal.family = "Terminess Nerd Font";
  launchd.agents."com.apple.rcd.plist".config.Disabled = true;

  targets.darwin.defaults = {
    "com.apple.dock" = {
      autohide = true; # enable hide and show dock
      autohide-delay = 0; # Remove the auto-hiding Dock delay
      mineffect = "scale"; # minimize windows using = scale effect
      minimize-to-application = true; # enable minimize windows into application icon
      orientation = "right";
      static-only = true; # set dock to only show active apps:
    };
    "com.apple.menuextra.clock" = {
      ShowSeconds = true; # this one works
      Show24Hour = true; # this one doesn't
    };
    NSGlobalDomain = {
      "com.apple.swipescrolldirection" = false; # disable natural scrolling
    };
  };
  targets.darwin.currentHostDefaults = {
    #"com.apple.driver.AppleBluetoothMultitouch.trackpad".Clicking = true; # enable tap to click
    NSGlobalDomain = {
      #"com.apple.mouse.tapBehavior" = 1; # enable tap to click
      InitialKeyRepeat = 15; # set delay until repeat
      KeyRepeat = 2; # set key repeat speed
      AppleKeyboardUIMode = 3; # enable keyboard navigation
      NSAutomaticDashSubstitutionEnabled = false; # disable smart dashes
      NSAutomaticQuoteSubstitutionEnabled = false; # disable smart quotes
      ApplePressAndHoldEnabled = false; # repeat keys instead of showing accented character selector
    };

    # https://apple.stackexchange.com/a/474905
    "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      "60" = {
        enabled = false; # disable "select previous input source"
      };
      "61" = {
        enabled = false; # disable "select next input source"
      };
      "70" = {
        enabled = false; # disable LookUp key combo
      };
    };
  };

  # Manual Additions  - FIXME
  # display scale = 2nd largest
  # external display resolution = 2560x1080
  # 24 hour clock
  # pointer acceleration
  # symlinked o11y-utils scripts diff, obrien, tshlogin

  # TODO
  # remove hot corner that opens Notes.app
  # remove window gaps "margins"
  # disable force click to LookUp
  # figure out which of the three tap-to-click settings actually works (requires reboot)
}
