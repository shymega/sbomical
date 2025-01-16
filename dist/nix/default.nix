# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0
{ rustPlatform
, lib
}:
let
  pname = "to-sbom";
  version = "0.1.0-unstable";

  inherit (rustPlatform) buildRustPackage;
in
buildRustPackage rec {
    inherit pname version;

    src = lib.cleanSource ../../.;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };

    meta = with lib; {
      description = "Utility for scanning software projects, and generating a SPDX-compliant SBOM.";
      homepage = "https://github.com/shymega/to-sbom";
      license = with licenses; asl20;
      maintainers = with maintainers; [ shymega ];
      mainProgram = "to-sbom";
    };
}
