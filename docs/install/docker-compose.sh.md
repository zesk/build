
# `dockerComposeInstall` - Install `docker-compose`

[⬅ Return to top](index.md)

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

## Usage

    dockerComposeInstall [ package ... ]
    bin/build/install/docker-compose.sh [ package ... ]

## Arguments

- `package` - Additional packages to install (using apt)

## Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
