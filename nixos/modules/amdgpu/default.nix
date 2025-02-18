{
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
