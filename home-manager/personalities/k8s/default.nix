{
  pkgs,
  ...
}: {
  imports = [
    ./k9s.nix
  ];
  home = {
    packages = with pkgs; [
      kubernetes-helm
      kubectl
    ];

    sessionVariables = {
      KUBECTL_EXTERNAL_DIFF = "diff --color=always -u";
    };

    shellAliases = {
      "k" = "kubectl";
    };
  };
}
