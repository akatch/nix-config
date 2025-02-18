{
  services.ddclient = {
    enable = true;
    domains = [
      "callisto"
    ];
    passwordFile = "/etc/nixos/ddclient";
    protocol = "namecheap";
    server = "dynamicdns.park-your-domain.com";
    username = "raktajino.club";
    usev4 = "web, web=dynamicdns.park-your-domain.com/getip";
  };
}
