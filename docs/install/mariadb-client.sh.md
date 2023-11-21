
# `mariadbInstall` - Install `mariadb`

[⬅ Return to top](index.md)

Install `mariadb`

If this fails it will output the installation log.

When this tool succeeds the `mariadb` binary is available in the local operating system.

## Usage

    mariadbInstall [ package ]
    bin/build/install/mariadb-client.sh [ package ... ]

## Arguments

- `package` - Additional packages to install

## Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

## Environment

- `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
