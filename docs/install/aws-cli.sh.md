
# `awsInstall` - aws Command-Line install

[⬅ Return to top](index.md)

aws Command-Line install

Installs x86 or aarch64 binary based on `$HOSTTYPE`.

## Usage

    awsInstall [ package ... ]

## Arguments

- `package` - One or more packages to install using `- `apt` - get` prior to installing AWS

## Exit codes

- if `aptInstall` fails, the exit code is returned

## Depends

    apt-get
