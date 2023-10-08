# Hooks

- `deploy-start.sh` - Begin deployment, after maintenane has been enabled
- `deploy-move.sh` - During deployment install passed directory as new version of the app in current directory
- `deploy-finish.sh` - Deployment is finished (before maintenance is turned off)
- `deploy-confirm.sh` - Before finish, check that deployment succeeded remotely via an alternate mechanism (smoke tests)
- `maintenance.sh -` Turn on or off maintenance
- `github-release-before.sh` -
- `make-env.sh` - Create the environment file (generally calls `bin/build/pipeline/make-env.sh` with your desired environment)
- `version-already.sh` - A new version was requested but it already exists
- `version-created.sh` - A new version was requested and created
- `version-current.sh` - The current version of the software in this codebase.
- `version-live.sh` - The current published live version of the software.
- `application-tag.sh` - The current tagged version of the software
- `application-checksum.sh` - Returns a string checksum of the current application source code (unique checksum for code state)

[⬅ Return to top](index.md)