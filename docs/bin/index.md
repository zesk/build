# Build utilities

[⬅ Return to top](../index.md)

These utilites can be accessed via the shell in the PATH:

    ./bin/build/

They are intended to be standalone tools useful for a variety of installation and package management functions:

- [`cannon.sh`](cannon.md) - Map strings in files to make global changes. Dangerous.
- [`identical-check.sh`](identical-check.md) - Look for identical code in many files and ensure it matches. Good for pre-commits.
- [`chmod-sh.sh`](chmod-sh.md) - Make `.sh` files executable. Also good for pre-commits.
- [`envmap.sh`](envmap.md) - Deprecated. See [`map.sh`](map.md)
- [`install-bin-build.sh`](install-bin-build.md) - Install this package from GitHub. Useful for build setup.
- [`map.sh`](map.md) - Map environment values into files. Useful for generating configuration files.
- [`new-release.sh`](new-release.md) - Create a new release for the current project.
- [`version-last.sh`](version-last.md) - The last version in the list of tags for this project
- [`version-list.sh`](version-list.md) - The list of versions for this project, in order by semantic versioning
- [`release-notes.sh`](release-notes.md) - Return path to current release notes file (`./docs/release/`)

[⬅ Return to top](../index.md)
