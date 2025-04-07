# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0
{
  description = "Suite for scanning software projects and generating SBOMs, as well as license reports.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs = inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" "riscv64-linux"];
    inherit (inputs) self;
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
          };
        });
  in
    {
      packages = forEachSupportedSystem ({pkgs}: {
        default = self.packages.${pkgs.system}.sbomical;
        sbomical = pkgs.callPackage ./dist/nix {inherit self;};
        devenv-up = self.devShells.${pkgs.system}.default.config.procfileScript;
        devenv-test = self.devShells.${pkgs.system}.default.config.test;
      });

      devShells = forEachSupportedSystem ({pkgs}: {
        default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [./dist/nix/devenv];
        };
      });
    }
    // {
      overlays.default = final: _: {
        inherit (self.packages.${final.system}) sbomical;
      };
    };
}
