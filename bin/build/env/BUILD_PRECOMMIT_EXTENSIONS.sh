#!/usr/bin/env bash
# List of extensions for which build hooks may be written and run
# Presence in this list simply means it may run, not that it is written or runs; add your own
# `bin/hooks/pre-commit-XXX.sh` to handle a specific file type in your application.
#
# Currently:
# - `sh` - Bash
# - `PHP` - PHP
# - `js` - JavaScript
# - `json` - JSON
# - `md` - Markdown
# - `yml` - Yet Another Markup Language
# - `txt` - Text files
# - `py` - Python
# - `go` - Golang
# - `rs` - Rust
# - `css` - CSS
# - `less`, `sass`, `scss` - Compiled stylesheets
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build Configuration
# Type: List
export BUILD_PRECOMMIT_EXTENSIONS
BUILD_PRECOMMIT_EXTENSIONS="${BUILD_PRECOMMIT_EXTENSIONS:-"sh php js json md yml txt py go rs css less sass scss"}"
