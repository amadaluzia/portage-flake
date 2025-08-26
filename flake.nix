{
  outputs = inputs @ {nixpkgs, ...}: let
    forAllSystems = f:
      nixpkgs.lib.genAttrs (import inputs.systems) (system:
        f system nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (_: pkgs: {
      portage = pkgs.callPackage ./flake/portage.nix {};
    });
    formatter =
      forAllSystems
      (_: pkgs: pkgs.callPackage ./flake/formatter.nix {});
  };
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };
    systems = {
      type = "github";
      owner = "nix-values";
      repo = "default-linux";
    };
  };
}
