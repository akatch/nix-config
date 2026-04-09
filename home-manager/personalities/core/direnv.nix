{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.direnv-instant.homeModules.direnv-instant
  ];

  programs.direnv-instant.enable = true;
}
