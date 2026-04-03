## `releaseNotes`

> Output path to current release notes

### Usage

    releaseNotes [ --application application ] [ version ]

Output path to current release notes
If this fails it outputs an error to stderr
When this tool succeeds it outputs the path to the current release notes file

### Arguments

- `--application application` - Directory. Optional. Application home directory.
- `version` - String. Optional. Version for the release notes path. If not specified uses the current version.

### Examples

    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

### Sample Output

docs/release/version.md

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_RELEASE_NOTES.sh}

