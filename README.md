<!--
  SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>

  SPDX-License-Identifier: Apache-2.0
-->


`sbomical`
==========

> Suite for scanning software projects and generating SBOMs, as well as license reports.

# About

sbomical is a suite of tools in one command that is primarily designed to run
in CI/build pipelines to generate licensing reports for source code, as well as
for dependencies in the form of a SBoM.

## Features

It's currently a WIP, and I'm working on it in my free time, but the general roadmap is below, in checkboxes.

- [ ] Generation of basic license reports based on copyright headers in files of a source code directory.
  - [ ] SPDX-compliant license reports.
- [ ] Specification-compliant SBOM manifests.
  - [ ] CycloneDX (all versions).
  - [ ] SPDX:
    - [ ] SPDX 2.2.
    - [ ] SPDX 2.3.
    - [ ] SPDX 3.0.
- [ ] Integration with various build systems/pipelines for reports, for example:
  - [ ] BuildStream (see: `freedesktop-sdk`)
  - [ ] Buildroot.
  - [ ] Generic executable calls for Makefiles and CMake generation processes.
  - [ ] GitHub Actions.
  - [ ] GitLab CI.
  - [ ] Nix.
  - [ ] Yocoto.
- [ ] SBOM and license generation reports of itself, for self-testing.
