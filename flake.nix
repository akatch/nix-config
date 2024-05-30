{
  description = "The temporal surge we detected was caused by an explosion of a microscopic singularity passing through this solar system. Somehow, the energy emitted by the singularity shifted the chroniton particles in our hull into a high state of temporal polarisation.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # `nixos-rebuild switch --flake .#$(hostname)`
    nixosConfigurations = {
      europa = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # `home-manager switch --flake .#$(whoami)@$(hostname)`
    homeConfigurations = {
      "al@europa" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home-manager/home.nix
          ./home-manager/personalities/core
          ./home-manager/personalities/desktop
          ./home-manager/personalities/desktop/swaywm
        ];
      };
    };
  };
}
