{
  nixpkgs.config = {
    experimental-features = "nix-command flake";
    allowUnfree = true;
  };
}
