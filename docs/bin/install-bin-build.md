
# `install-bin-build.sh` - Installs the build system in `./bin/build` if not installed. Also

[⬅ Return to top](index.md)

Installs the build system in `./bin/build` if not installed. Also
will overwrite this binary with the latest version after installation.

Determines the most recent version using GitHub API unless --url or --local is specified.

## Arguments



## Exit codes

- `1` - Environment error
- `2` - Argument error

## Environment

Needs internet access and creates a directory `./bin/build`
