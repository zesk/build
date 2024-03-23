
# `install-bin-build.sh` - Installs the build system in `./bin/build` if not installed. Also

[⬅ Return to top](index.md)

Installs the build system in `./bin/build` if not installed. Also
will overwrite this binary with the latest version after installation.
Determines the most recent version using GitHub API unless --url or --mock is specified.

## Usage

    install-bin-build.sh [ --mock mockBuildRoot ] [ --url url ]
    

## Arguments



## Exit codes

- `1` - Environment error

## Environment

Needs internet access and creates a directory `./bin/build`
