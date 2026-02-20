{
  pkgs,
  ...
}: {
  networking.firewall.checkReversePath = false;

  environment.systemPackages = with pkgs; [
    protonvpn-gui
    wireguard-tools
  ];
}
