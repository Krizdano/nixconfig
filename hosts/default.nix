{ home-manager, nixpkgs, inputs, user, location, stable, impermanence, nixvim, secrets, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  Felix = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user location inputs secrets;
    };
    modules = [
      ./configuration.nix
      ./persist.nix
      ./felix

      ({ config, pkgs, ... }:
        let
          overlay-unstable = final: prev: {
            stable = stable.legacyPackages.x86_64-linux;
          };
        in
        {
          nixpkgs.overlays = [
            overlay-unstable
            (import ../overlays)
          ];
        })

      impermanence.nixosModules.impermanence


      home-manager.nixosModules.home-manager
      {
        home-manager.users.${user} = {
          imports = [
            impermanence.nixosModules.home-manager.impermanence
            nixvim.homeManagerModules.nixvim
            ./felix/home.nix
          ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit secrets; };
      }
    ];
  };

  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs location; };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
  iso = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs location; };
    modules = [
      (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ./iso

      home-manager.nixosModules.home-manager
      {
        home-manager.users.${user} = {
          imports = [
            # impermanence.nixosModules.home-manager.impermanence
            nixvim.homeManagerModules.nixvim
          ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}

