# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

{ 
  description = "Suite for scanning software projects and generating SBOMs, as well as license reports.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" "riscv64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs {
          inherit system;
        };
      });
    in
    {
      packages = forEachSupportedSystem ({ pkgs }:{
        default = self.packages.${pkgs.system}.sbomical;
        sbomical = pkgs.callPackage ./dist/nix { inherit self; };
      });

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          inputsFrom = [ self.packages.${pkgs.system}.sbomical ];
        };
      });
    } // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) sbomical;
      };
    };
}
