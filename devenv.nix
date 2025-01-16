# SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
#
# SPDX-License-Identifier: Apache-2.0
{
  languages = {
    nix.enable = true;
    rust.enable = true;
    shell.enable = true;
  };
  devcontainer.enable = true;
  difftastic.enable = true;
  git-hooks = {
    excludes = [
      ".direnv/"
      ".devenv/"
      ".devenv.flake.nix"
      ".devenv.d*/"
    ];

    hooks = {
      actionlint.enable = true;
      alejandra = {
        enable = true;
      };
      deadnix = {
        enable = true;
      };
      markdownlint = {
        enable = true;
      };
      reuse = {
        enable = false;
      };
      statix = {
        enable = true;
        settings.ignore = [
          ".direnv/"
          ".devenv/"
          ".devenv.flake.nix"
          ".devenv*/"
        ];
      };
    };
  };
}
