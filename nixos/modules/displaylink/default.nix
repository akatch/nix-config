{
  #nixpkgs,
  #pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "displaylink"
  ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # shoutout to @hughobrien
  # https://gitlab.freedesktop.org/wlroots/wlroots/-/issues/1823#note_2308139
  nixpkgs.overlays = [
    (final: prev: {
      wlroots_0_17 = prev.wlroots_0_17.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://gitlab.freedesktop.org/wlroots/wlroots/uploads/b4f932e370ed03d88f202191eaf60965/DisplayLink.patch";
            hash = "sha256-1HheLsOSnj4OMiA35QCHkWprTNgAeG2tXrGbaQyUrF4=";
          })
        ];
      });
    })
  ];

  environment = {
    variables = {
      WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    };
  };
}
