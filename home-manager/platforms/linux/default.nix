{
  config,
  ...
}: {
  home = {
    homeDirectory = "/home/${config.home.username}";
    preferXdgDirectories = true;
  };
}
