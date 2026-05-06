## `gitTagVersion`

> Generates a git tag for a build version, so `v1.0d1`,

### Usage

    gitTagVersion [ --suffix versionSuffix ]

Generates a git tag for a build version, so `v1.0d1`, `v1.0d2`, for version `v1.0`.
Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.

- `d` - for **development**
- `s` - for **staging**
- `rc` - for **release candidate**

> Location: `bin/build/tools/git.sh`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

