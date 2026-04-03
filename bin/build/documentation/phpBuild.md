## `phpBuild`

> Build deployment using composer, adding environment values to .env and

### Usage

    phpBuild [ --skip-tag | --no-tag ] [ --name tarFileName ] [ --composer arg ] [ --help ] [ environmentVariable ... ] -- file1 file2 dir3 ...

Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into target file, usually `BUILD_TARGET`
Override target file generated with environment variable `BUILD_TARGET` which must ae set during build
and on remote systems during deployment.
Files are specified from the application root directory.
`phpBuild` generates the `.build.env` file, which contains the current environment and:
- BUILD_TARGET
- BUILD_START_TIMESTAMP
- APPLICATION_TAG
- APPLICATION_ID

### Arguments

--skip-tag |- ` --no-tag` - Flag. Optional. Do not tag the release.
- `--name tarFileName` - String. Optional. Set BUILD_TARGET via command line (wins)
- `--composer arg` - Argument. Optional. Supply one or more arguments to `phpComposer` command. (Use multiple times)
- `--help` - Flag. Optional. Display this help.
- `environmentVariable ...` - EnvironmentVariable. Optional. Environment variables to build into the deployed .env file
- `--` - Separator. Required. Separates environment variables to file list
- `file1 file2 dir3 ...` - File|Directory. Required. List of files and directories to build into the application package.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### See Also

- {SEE:BUILD_TARGET.sh}

