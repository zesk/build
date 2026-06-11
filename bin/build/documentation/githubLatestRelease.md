### `githubLatestRelease`

> Get the latest release version

#### Usage

    githubLatestRelease projectName

Get the latest release version

> Location: `bin/build/tools/github.sh`

#### Arguments

- `projectName` - String. Required. Github project name in the form of `owner/repository`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`GITHUB_ACCESS_TOKEN` GitHub Access Token]({rel}/env/#development) – **Secret**. Access token used for release

