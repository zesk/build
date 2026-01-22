#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--token token - String. Optional. Uses \`GITHUB_ACCESS_TOKEN\` if not supplied. Access token for GitHub REST API."$'\n'"--owner owner - String. Optional. Uses \`GITHUB_REPOSITORY_OWNER\` if not supplied. Repository owner of release."$'\n'"--name name - String. Optional. Uses \`GITHUB_REPOSITORY_NAME\` if not supplied. Repository name to release."$'\n'"--expire expireString - String. Optional. Uses \`GITHUB_ACCESS_TOKEN_EXPIRE\` if not supplied. Expiration time for the token."$'\n'"descriptionFilePath - File. Required. File which exists. Path to file containing release notes (typically markdown)"$'\n'"releaseName - String. Required. Name of the release (e.g. \`v1.0.0\`)"$'\n'"commitish - String. Required. The GIT short SHA tag for the release"$'\n'""
base="github.sh"
description="Use GitHub API to generate a release"$'\n'""$'\n'"GitHub MUST have two sets of credentials enabled:"$'\n'""$'\n'"- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)"$'\n'" - Found here: https://github.com/\$repoOwner/\$repoName/settings/keys"$'\n'"- The \`token\` must have the permission to create releases for this repository"$'\n'" - Found here: https://github.com/settings/tokens"$'\n'""$'\n'"Think of them of the \"source\" (user) and \"target\" (ssh key) access. Both must exist to work."$'\n'""
environment="- \`GITHUB_ACCESS_TOKEN\` - Access to GitHub to publish releases"$'\n'"- \`GITHUB_ACCESS_TOKEN_EXPIRE\` - Date in \`YYYY-MM-DD\` format which represents the date when \`GITHUB_ACCESS_TOKEN\` expires (required)"$'\n'"- \`GITHUB_REPOSITORY_OWNER\` - Owner of the repository (\`https://github.com/owner\`)"$'\n'"- \`GITHUB_REPOSITORY_NAME\` - Name of the repository (\`https://github.com/owner/name\`)"$'\n'"GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubRelease"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1768759150"
summary="Generate a release on GitHub using API"$'\n'""
usage="githubRelease [ --help ] [ --handler handler ] [ --token token ] [ --owner owner ] [ --name name ] [ --expire expireString ] descriptionFilePath releaseName commitish"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgithubRelease[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --token token ][0m [94m[ --owner owner ][0m [94m[ --name name ][0m [94m[ --expire expireString ][0m [38;2;255;255;0m[35;48;2;0;0;0mdescriptionFilePath[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mreleaseName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommitish[0m[0m

    [94m--help                 [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler      [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--token token          [1;97mString. Optional. Uses [38;2;0;255;0;48;2;0;0;0mGITHUB_ACCESS_TOKEN[0m if not supplied. Access token for GitHub REST API.[0m
    [94m--owner owner          [1;97mString. Optional. Uses [38;2;0;255;0;48;2;0;0;0mGITHUB_REPOSITORY_OWNER[0m if not supplied. Repository owner of release.[0m
    [94m--name name            [1;97mString. Optional. Uses [38;2;0;255;0;48;2;0;0;0mGITHUB_REPOSITORY_NAME[0m if not supplied. Repository name to release.[0m
    [94m--expire expireString  [1;97mString. Optional. Uses [38;2;0;255;0;48;2;0;0;0mGITHUB_ACCESS_TOKEN_EXPIRE[0m if not supplied. Expiration time for the token.[0m
    [31mdescriptionFilePath    [1;97mFile. Required. File which exists. Path to file containing release notes (typically markdown)[0m
    [31mreleaseName            [1;97mString. Required. Name of the release (e.g. [38;2;0;255;0;48;2;0;0;0mv1.0.0[0m)[0m
    [31mcommitish              [1;97mString. Required. The GIT short SHA tag for the release[0m

Use GitHub API to generate a release

GitHub MUST have two sets of credentials enabled:

- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
 - Found here: https://github.com/$repoOwner/$repoName/settings/keys
- The [38;2;0;255;0;48;2;0;0;0mtoken[0m must have the permission to create releases for this repository
 - Found here: https://github.com/settings/tokens

Think of them of the "source" (user) and "target" (ssh key) access. Both must exist to work.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - [38;2;0;255;0;48;2;0;0;0mGITHUB_ACCESS_TOKEN[0m - Access to GitHub to publish releases
- - [38;2;0;255;0;48;2;0;0;0mGITHUB_ACCESS_TOKEN_EXPIRE[0m - Date in [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m format which represents the date when [38;2;0;255;0;48;2;0;0;0mGITHUB_ACCESS_TOKEN[0m expires (required)
- - [38;2;0;255;0;48;2;0;0;0mGITHUB_REPOSITORY_OWNER[0m - Owner of the repository ([38;2;0;255;0;48;2;0;0;0mhttps://github.com/owner[0m)
- - [38;2;0;255;0;48;2;0;0;0mGITHUB_REPOSITORY_NAME[0m - Name of the repository ([38;2;0;255;0;48;2;0;0;0mhttps://github.com/owner/name[0m)
- GITHUB_ACCESS_TOKEN
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: githubRelease [ --help ] [ --handler handler ] [ --token token ] [ --owner owner ] [ --name name ] [ --expire expireString ] descriptionFilePath releaseName commitish

    --help                 Flag. Optional. Display this help.
    --handler handler      Function. Optional. Use this error handler instead of the default error handler.
    --token token          String. Optional. Uses GITHUB_ACCESS_TOKEN if not supplied. Access token for GitHub REST API.
    --owner owner          String. Optional. Uses GITHUB_REPOSITORY_OWNER if not supplied. Repository owner of release.
    --name name            String. Optional. Uses GITHUB_REPOSITORY_NAME if not supplied. Repository name to release.
    --expire expireString  String. Optional. Uses GITHUB_ACCESS_TOKEN_EXPIRE if not supplied. Expiration time for the token.
    descriptionFilePath    File. Required. File which exists. Path to file containing release notes (typically markdown)
    releaseName            String. Required. Name of the release (e.g. v1.0.0)
    commitish              String. Required. The GIT short SHA tag for the release

Use GitHub API to generate a release

GitHub MUST have two sets of credentials enabled:

- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)
 - Found here: https://github.com/$repoOwner/$repoName/settings/keys
- The token must have the permission to create releases for this repository
 - Found here: https://github.com/settings/tokens

Think of them of the "source" (user) and "target" (ssh key) access. Both must exist to work.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - GITHUB_ACCESS_TOKEN - Access to GitHub to publish releases
- - GITHUB_ACCESS_TOKEN_EXPIRE - Date in YYYY-MM-DD format which represents the date when GITHUB_ACCESS_TOKEN expires (required)
- - GITHUB_REPOSITORY_OWNER - Owner of the repository (https://github.com/owner)
- - GITHUB_REPOSITORY_NAME - Name of the repository (https://github.com/owner/name)
- GITHUB_ACCESS_TOKEN
- 
'
