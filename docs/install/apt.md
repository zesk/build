
# `aptInstall` - Install packages using `apt-get`

[⬅ Return to top](index.md)

Install packages using `apt-get`. If `apt-get` is not available, this succeeds
and assumes packages will be available.

## Usage

    aptInstall [ package ... ]
    

## Arguments

- `package` - One or more packages to install

## Examples

    aptInstall shellcheck

## Exit codes

- `0` - If `apt-get` is not installed, returns 0.
- `1` - If `apt-get` fails to install the packages
