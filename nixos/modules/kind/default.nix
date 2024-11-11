{
  pkgs,
  ...
}: {
  systemd.services."kind" = {
    description = "Manage state of the KinD podman container";
    script =
      ''
        ${pkgs.podman}/bin/podman start $(${pkgs.podman}/bin/podman container ls --all --quiet --noheading --filter name=kind-control-plane)
      '';
    serviceConfig = {
      Type = "exec";
      User = "al";
    };
  };
}
