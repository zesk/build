#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/crontab.sh"
argument="--env-file environmentFile - Top-level environment file to pass variables into the user \`crontab\` template"$'\n'"--show - Show the crontab instead of installing it"$'\n'"--user user - Scan for crontab files in the form \`user.crontab\` and then install as this user. If not specified, uses current user name."$'\n'"--mapper envMapper - Binary. Optional. The binary use to map environment values to the file. (Uses \`mapEnvironment\` by default)"$'\n'""
base="crontab.sh"
description="Keep crontab synced with files and environment files in an application folder structure."$'\n'""$'\n'"Structure is:"$'\n'""$'\n'"- \`appPath/application1/.env\`"$'\n'"- \`appPath/application1/.env.local\`"$'\n'"- \`appPath/application1/etc/user.crontab\`"$'\n'""$'\n'"Search for \`user.crontab\` in \`applicationPath\` and when found, assign \`APPLICATION_NAME\` to the top-level directory name"$'\n'"and \`APPLICATION_PATH\` to the top-level directory path and then map the file using the environment files given."$'\n'"Any \`.env\` or \`.env.local\` files found at \`\$applicationPath/\` will be included for each file generation."$'\n'""$'\n'"Feasibly for each file, the following environment files are loaded:"$'\n'""$'\n'"1. \`rootEnv\`"$'\n'"2. \`applicationPath/applicationName/.env\`"$'\n'"3. \`applicationPath/applicationName/.env.local\`"$'\n'""$'\n'"Any files not found are skipped. Note that environment values are not carried between applications."$'\n'""$'\n'""
example="    crontabApplicationUpdate --env-file /etc/myCoolApp.conf --user www-data /var/www/applications"$'\n'"    crontabApplicationUpdate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh"$'\n'""
file="bin/build/tools/crontab.sh"
fn="crontabApplicationUpdate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="whoami"$'\n'""
sourceFile="bin/build/tools/crontab.sh"
sourceModified="1768721469"
summary="Application-specific crontab management"$'\n'""
usage="crontabApplicationUpdate [ --env-file environmentFile ] [ --show ] [ --user user ] [ --mapper envMapper ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcrontabApplicationUpdate[0m [94m[ --env-file environmentFile ][0m [94m[ --show ][0m [94m[ --user user ][0m [94m[ --mapper envMapper ][0m

    [94m--env-file environmentFile  [1;97mTop-level environment file to pass variables into the user [38;2;0;255;0;48;2;0;0;0mcrontab[0m template[0m
    [94m--show                      [1;97mShow the crontab instead of installing it[0m
    [94m--user user                 [1;97mScan for crontab files in the form [38;2;0;255;0;48;2;0;0;0muser.crontab[0m and then install as this user. If not specified, uses current user name.[0m
    [94m--mapper envMapper          [1;97mBinary. Optional. The binary use to map environment values to the file. (Uses [38;2;0;255;0;48;2;0;0;0mmapEnvironment[0m by default)[0m

Keep crontab synced with files and environment files in an application folder structure.

Structure is:

- [38;2;0;255;0;48;2;0;0;0mappPath/application1/.env[0m
- [38;2;0;255;0;48;2;0;0;0mappPath/application1/.env.local[0m
- [38;2;0;255;0;48;2;0;0;0mappPath/application1/etc/user.crontab[0m

Search for [38;2;0;255;0;48;2;0;0;0muser.crontab[0m in [38;2;0;255;0;48;2;0;0;0mapplicationPath[0m and when found, assign [38;2;0;255;0;48;2;0;0;0mAPPLICATION_NAME[0m to the top-level directory name
and [38;2;0;255;0;48;2;0;0;0mAPPLICATION_PATH[0m to the top-level directory path and then map the file using the environment files given.
Any [38;2;0;255;0;48;2;0;0;0m.env[0m or [38;2;0;255;0;48;2;0;0;0m.env.local[0m files found at [38;2;0;255;0;48;2;0;0;0m$applicationPath/[0m will be included for each file generation.

Feasibly for each file, the following environment files are loaded:

1. [38;2;0;255;0;48;2;0;0;0mrootEnv[0m
2. [38;2;0;255;0;48;2;0;0;0mapplicationPath/applicationName/.env[0m
3. [38;2;0;255;0;48;2;0;0;0mapplicationPath/applicationName/.env.local[0m

Any files not found are skipped. Note that environment values are not carried between applications.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    crontabApplicationUpdate --env-file /etc/myCoolApp.conf --user www-data /var/www/applications
    crontabApplicationUpdate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh
'
# shellcheck disable=SC2016
helpPlain='Usage: crontabApplicationUpdate [ --env-file environmentFile ] [ --show ] [ --user user ] [ --mapper envMapper ]

    --env-file environmentFile  Top-level environment file to pass variables into the user crontab template
    --show                      Show the crontab instead of installing it
    --user user                 Scan for crontab files in the form user.crontab and then install as this user. If not specified, uses current user name.
    --mapper envMapper          Binary. Optional. The binary use to map environment values to the file. (Uses mapEnvironment by default)

Keep crontab synced with files and environment files in an application folder structure.

Structure is:

- appPath/application1/.env
- appPath/application1/.env.local
- appPath/application1/etc/user.crontab

Search for user.crontab in applicationPath and when found, assign APPLICATION_NAME to the top-level directory name
and APPLICATION_PATH to the top-level directory path and then map the file using the environment files given.
Any .env or .env.local files found at $applicationPath/ will be included for each file generation.

Feasibly for each file, the following environment files are loaded:

1. rootEnv
2. applicationPath/applicationName/.env
3. applicationPath/applicationName/.env.local

Any files not found are skipped. Note that environment values are not carried between applications.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    crontabApplicationUpdate --env-file /etc/myCoolApp.conf --user www-data /var/www/applications
    crontabApplicationUpdate /etc/myCoolApp.conf /var/www/applications www-data /usr/local/bin/map.sh
'
