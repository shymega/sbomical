# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0
{
  rustPlatform,
  lib,
  self,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "sbomical";
  version = "unstable";

  src = lib.cleanSource self;

  cargoLock = {
    lockFile = "${finalAttrs.src}/Cargo.lock";
  };

  meta = {
    description = "Suite for scanning software projects and generating SBOMs, as well as license reports.";
    homepage = "https://github.com/shymega/sbomical";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [shymega];
    mainProgram = "sbomical";
  };
})
