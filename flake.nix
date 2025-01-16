# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

{ 
  description = "Utility for scanning software projects, and generating a SPDX-compliant SBOM.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" "riscv64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default.${system} ];
        };
      });
    in
    {
      overlays.default = forEachSupportedSystem ({ pkgs }:
        final: _: {
        inherit (self.packages.${final.system}) to-sbom;
      });

      packages = forEachSupportedSystem ({ pkgs }:{
        default = self.packages.${pkgs.system}.to-sbom;
        to-sbom = pkgs.callPackage ./dist/nix { };
      });

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          inputsFrom = [ self.packages.${pkgs.system}.to-sbom ];
        };
      });
    };
}
