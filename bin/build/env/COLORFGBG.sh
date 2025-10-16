#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
# Standard way to express the foreground and background colors
#
# - Format is: `foregroundColor` `;` `backgroundColor`
# - `foregroundColor` - UnsignedInteger. 0 to 16
# - `backgroundColor` - UnsignedInteger. 0 to 16
#
# Not referenced in this product; referenced via [rxvt](https://rxvt.sourceforge.net/) and may be honored at some point.
# Category: Decoration
# Type: String
export COLORFGBG
COLORFGBG="${COLORFGBG-}"
