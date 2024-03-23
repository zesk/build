# GitHub Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `githubLatestRelease` - Get the latest release version

Get the latest release version

#### Usage

    githubLatestRelease projectName [ ... ]
    

#### Exit codes

- `0` - Always succeeds

### `githubRelease` - Generate a release on GitHub using API

Use GitHub API to generate a release

GitHub MUST have two sets of credentials enabled:

- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
- The `token` must have the permission to create releases for this repository

Think of them of the "source" (user) and "target" (ssh key) access. Both must exist to work.

#### Usage

    githubRelease [ --token token ] [ --owner owner ] [ --name name ] [ --expire expire ] descriptionFilePath releaseName commitish
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

GITHUB_ACCESS_TOKEN - Access to GitHub to publish releases
GITHUB_ACCESS_TOKEN_EXPIRE - Date in `YYYY-MM-DD` format which represents the date when `GITHUB_ACCESS_TOKEN` expires (required)
GITHUB_REPOSITORY_OWNER - Owner of the repository (`https://github.com/owner`)
GITHUB_REPOSITORY_NAME - Name of the repository (`https://github.com/owner/name`)

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
