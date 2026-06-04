### `dockerComposeInstall`

> Install `docker-compose`

#### Usage

    dockerComposeInstall [ package ]

Install `docker-compose`

If this fails it will output the installation log.

When this tool succeeds the `docker-compose` binary is available in the local operating system.

> Location: `bin/build/tools/docker-compose.sh`

#### Arguments

- `package` - Additional packages to install (using `pipInstall`)

#### Return codes

- `1` - If installation fails
- `0` - If installation succeeds

#### See Also

- [pipInstall]({rel}tools/python.md#pipinstall) - Utility to install python dependencies via pip ([source](https://github.com/zesk/build/blob/main/bin/build/tools/python.sh#L86))

