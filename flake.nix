{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: let
    vsc-go-away-llms = import ./package.nix;

    overlays.default = final: _: {
      vsc-go-away-llms = final.callPackage vsc-go-away-llms { };
    };

    forEachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

    packages = forEachSystem (system: {
      default = nixpkgs.legacyPackages.${system}.callPackage vsc-go-away-llms { };
    });

    devShells = forEachSystem (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = [ packages.${system}.default ];
      };
    });
  in {
    inherit overlays packages devShells;
  };
}
