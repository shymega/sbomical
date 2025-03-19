// SPDX-FileCopyrightText: 2025 Dom Rodriguez <Dom.Rodriguez@codethink.co.uk>
//
// SPDX-License-Identifier: Apache-2.0

use std::io::{self, Result as IoResult};
use std::process::Output;

pub trait BuildSystem {
    fn get_system_kind(&self) -> &'static str; // change to enum
}

pub trait BuildStreamSystem : BuildSystem {
}
