#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/crontab.sh"
argument="--env-file environmentFile - Top-level environment file to pass variables into the user \`crontab\` template"$'\n'"--show - Show the crontab instead of installing it"$'\n'"--user user - Scan for crontab files in the form \`user.crontab\` and then install as this user. If not specified, uses current user name."$'\n'"--mapper envMapper - Binary. Optional.The binary use to map environment values to the file. (Uses \`mapEnvironment\` by default)"$'\n'""
base="crontab.sh"
description="Keep crontab synced with files and environment files in an application folder structure."$'\n'""$'\n'"Structure is:"$'\n'""$'\n'"- \`appPath/application1/.env\`"$'\n'"- \`appPath/application1/.env.local\`"$'\n'"- \`appPath/application1/etc/user.crontab\`"$'\n'""$'\n'"Search for \`user.crontab\` in \`applicationPath\` and when found, assign \`APPLICATION_NAME\` to the top-level directory name"$'\n'"and \`APPLICATION_PATH\` to the top-level directory path and then map the file using the environment files given."$'\n'"Any \`.env\` or \`.env.local\` files found at \`\$applicationPath/\` will be included for each file generation."$'\n'""$'\n'"Feasibly for each file, the following environment files are loaded:"$'\n'""$'\n'"1. \`rootEnv\`"$'\n'"2. \`applicationPath/applicationName/.env\`"$'\n'"3. \`applicationPath/applicationName/.env.local\`"$'\n'""$'\n'"Any files not found are skipped. Note that environment values are not carried between applications."$'\n'""$'\n'""
example="    crontabApplicationUpdate --env-file /etc/myCoolApp.conf --user www-data /var/www/applications"$'\n'"    crontabApplicationUpdate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh"$'\n'""
file="bin/build/tools/crontab.sh"
fn="crontabApplicationUpdate"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="whoami"$'\n'""
source="bin/build/tools/crontab.sh"
sourceModified="1768695708"
summary="Application-specific crontab management"$'\n'""
usage="crontabApplicationUpdate [ --env-file environmentFile ] [ --show ] [ --user user ] [ --mapper envMapper ]"
