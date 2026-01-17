#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--handler handler -  Function. Optional.Use this error handler instead of the default error handler."$'\n'"--token token - Optional. Uses \`GITHUB_ACCESS_TOKEN\` if not supplied. Access token for GitHub REST API."$'\n'"--owner owner - Optional. Uses \`GITHUB_REPOSITORY_OWNER\` if not supplied. Repository owner of release."$'\n'"--name name - Optional. Uses \`GITHUB_REPOSITORY_NAME\` if not supplied. Repository name to release."$'\n'"--expire expireString - Optional. Uses \`GITHUB_ACCESS_TOKEN_EXPIRE\` if not supplied. Expiration time for the token."$'\n'"descriptionFilePath - Required. File which exists. Path to file containing release notes (typically markdown)"$'\n'"releaseName - String. Required. Name of the release (e.g. \`v1.0.0\`)"$'\n'"commitish - String. Required. The GIT short SHA tag for the release"$'\n'""
base="github.sh"
description="Use GitHub API to generate a release"$'\n'""$'\n'"GitHub MUST have two sets of credentials enabled:"$'\n'""$'\n'"- The SSH key for the deployment robot should have push access to the repository on GitHub to enable releases (git handles this)"$'\n'" - Found here: https://github.com/\$repoOwner/\$repoName/settings/keys"$'\n'"- The \`token\` must have the permission to create releases for this repository"$'\n'" - Found here: https://github.com/settings/tokens"$'\n'""$'\n'"Think of them of the \"source\" (user) and \"target\" (ssh key) access. Both must exist to work."$'\n'""
environment="- \`GITHUB_ACCESS_TOKEN\` - Access to GitHub to publish releases"$'\n'"- \`GITHUB_ACCESS_TOKEN_EXPIRE\` - Date in \`YYYY-MM-DD\` format which represents the date when \`GITHUB_ACCESS_TOKEN\` expires (required)"$'\n'"- \`GITHUB_REPOSITORY_OWNER\` - Owner of the repository (\`https://github.com/owner\`)"$'\n'"- \`GITHUB_REPOSITORY_NAME\` - Name of the repository (\`https://github.com/owner/name\`)"$'\n'"GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubRelease"
foundNames=([0]="summary" [1]="argument" [2]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/github.sh"
sourceModified="1768683999"
summary="Generate a release on GitHub using API"$'\n'""
usage="githubRelease [ --help ] [ --handler handler ] [ --token token ] [ --owner owner ] [ --name name ] [ --expire expireString ] descriptionFilePath releaseName commitish"
