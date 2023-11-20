
# `buildSetup` - Installs the build system in `./bin/build` if not installed. Also

[⬅ Return to top](index.md)

Installs the build system in `./bin/build` if not installed. Also
will overwrite this binary with the latest version after installation.

## Usage

    buildSetup [ --mock mockBuildRoot ]

## Exit codes

- `1` - Environment error

## Environment

Needs internet access and creates a directory `./bin/build`
