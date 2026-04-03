## `dockerCompose`

> docker compose wrapper with automatic .env support

### Usage

    dockerCompose [ --help ] [ --handler handler ] [ --production ] [ --staging ] [ --deployment deploymentName ] [ --volume ] [ --build ] [ --clean ] [ --keep ] [ --default-env | --env environmentNameValue ] [ --env environmentNameValue ] [ --arg environmentNameValue ] [ composeCommand ]

docker compose wrapper with automatic .env support
Environment files are managed automatically by this function (with backups).
Environment files are named in stringUppercase after the deployment as `.DEPLOYMENT.env` in the home directory
So, `.STAGING.env` and `.PRODUCTION.env` are the default environments. They are copied into `.env` with any additional required
default environment variables (including `DEPLOYMENT=`), and then this `.env` file serves as the basis for both the
`docker-compose.yml` generation (any variable defined here is mapped into this file - by default) and ultimately may be
copied into the container as configuration settings.
Custom deployment settings can be set up using the `--deployment deploymentName` argument.
Volume name, by default is named after the directory name of the project suffixed with `_database_data`.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--production` - Flag. Production container build. Shortcut for `--deployment production` (uses `.PRODUCTION.env`)
- `--staging` - Flag. Staging container build. Shortcut for `--deployment staging` (uses `.STAGING.env`)
- `--deployment deploymentName` - String. Deployment name to use. (uses `.$(stringUppercase "$deploymentName").env`)
- `--volume` - String. Name of the volume associated with the container to preserve or delete.
- `--build` - Flag. `build` command with volume management
- `--clean` - Flag. Delete the volume prior to building.
- `--keep` - Flag. Keep the volume during build.
--default-env |- ` --env environmentNameValue` - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file.
- `--env environmentNameValue` - EnvironmentNameValue. An environment variable name and value (in the form `NAME=value` to require in the `.env` file. If set already in the file or in the environment then has no effect.
- `--arg environmentNameValue` - EnvironmentNameValue. Passed as an ARG to the build environment – a variable name and value (in the form `NAME=value` to require in the `.env` file. If set already in the file or in the environment then has no effect.
- `composeCommand` - You can send any compose command and arguments thereafter are passed to `docker compose`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

