### `githubVersionLive`

> Fetch the current live version of software using GitHub APIs

#### Usage

    githubVersionLive [ --help ] [ --handler handler ] [ --name name ] [ --owner owner ]

Fetch the current live version of software using GitHub APIs

> Location: `bin/build/tools/github.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--name name` - String. Optional. GitHub repository name to use. If not specified, uses `{env:GITHUB_REPOSITORY_NAME}`.
- `--owner owner` - String. Optional. GitHub repository owner to use. If not specified, uses `{env:GITHUB_REPOSITORY_OWNER}`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:GITHUB_REPOSITORY_OWNER}
- {SEE:GITHUB_REPOSITORY_NAME}

