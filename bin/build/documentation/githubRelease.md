## `githubRelease`

> Generate a release on GitHub using API

### Usage

    githubRelease [ --help ] [ --handler handler ] [ --token token ] [ --owner owner ] [ --name name ] [ --expire expireString ] descriptionFilePath releaseName commitish

Use GitHub API to generate a release
GitHub MUST have two sets of credentials enabled:
- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
- The `token` must have the permission to create releases for this repository
Think of them of the "source" (user) and "target" (ssh key) access. Both must exist to work.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--token token` - String. Optional. Uses `GITHUB_ACCESS_TOKEN` if not supplied. Access token for GitHub REST API.
- `--owner owner` - String. Optional. Uses `GITHUB_REPOSITORY_OWNER` if not supplied. Repository owner of release.
- `--name name` - String. Optional. Uses `GITHUB_REPOSITORY_NAME` if not supplied. Repository name to release.
- `--expire expireString` - String. Optional. Uses `GITHUB_ACCESS_TOKEN_EXPIRE` if not supplied. Expiration time for the token.
- `descriptionFilePath` - File. Required. File which exists. Path to file containing release notes (typically markdown)
- `releaseName` - String. Required. Name of the release (e.g. `v1.0.0`)
- `commitish` - String. Required. The GIT short SHA tag for the release

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- - `GITHUB_ACCESS_TOKEN` - Access to GitHub to publish releases
- - `GITHUB_ACCESS_TOKEN_EXPIRE` - Date in `YYYY-MM-DD` format which represents the date when `GITHUB_ACCESS_TOKEN` expires (required)
- - `GITHUB_REPOSITORY_OWNER` - Owner of the repository (`https://github.com/owner`)
- - `GITHUB_REPOSITORY_NAME` - Name of the repository (`https://github.com/owner/name`)
- {SEE:GITHUB_ACCESS_TOKEN.sh}

