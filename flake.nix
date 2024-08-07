# My personal Nixos flake
# this is a flake manages my Nixos Configuration

{
  description = "My personal Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs?ref=release-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, home-manager, nixpkgs, impermanence, stable, nixvim, ... }@inputs:
    let
      location = "$HOME/.nixconfig";
      secrets = import ./secrets.nix;
      user = secrets.users.primary.userName;
    in
      {
        formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
        nixosConfigurations = (
          import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs nixpkgs home-manager user location impermanence nixvim stable secrets;
          });
      };

}
