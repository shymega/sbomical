# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0
(
  import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      nodeName = lock.nodes.root.inputs.flake-compat;
    in
      fetchTarball {
        url = lock.nodes.${nodeName}.locked.url or "https://github.com/edolstra/flake-compat/archive/${lock.nodes.${nodeName}.locked.rev}.tar.gz";
        sha256 = lock.nodes.${nodeName}.locked.narHash;
      }
  )
  {src = ./.;}
)
.defaultNix
