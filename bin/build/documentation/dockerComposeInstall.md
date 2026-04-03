## `dockerComposeInstall`

> Install `docker-compose`

### Usage

    dockerComposeInstall [ package ]

Install `docker-compose`
If this fails it will output the installation log.
When this tool succeeds the `docker-compose` binary is available in the local operating system.

### Arguments

- `package` - Additional packages to install (using `pipInstall`)

### Return codes

- `1` - If installation fails
- `0` - If installation succeeds

