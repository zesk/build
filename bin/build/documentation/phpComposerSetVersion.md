## `phpComposerSetVersion`

> For any project, ensures the `version` field in `composer.json` matches

### Usage

    phpComposerSetVersion [ --version ] [ --home ] [ --status ] [ --quiet ]

For any project, ensures the `version` field in `composer.json` matches `hookRun version-current`
Run as a commit hook for any PHP project or as part of your build or development process
Typically the version is copied in without the leading `v`.

### Arguments

- `--version` - String. Use this version instead of current version.
- `--home` - Directory. Optional. Use this directory for the location of `composer.json`.
- `--status` - Flag. Optional. When set, returns 0 when te version was updated successfully and $(returnCode identical) when the files are the same
- `--quiet` - Flag. Optional. Do not output anything to stdout and just do the action and exit.

### Return codes

- `0` - File was updated successfully.
- `1` - Environment error
- `2` - Argument error
- `105` - Identical files (only when --status is passed)

