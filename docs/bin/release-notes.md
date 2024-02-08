
# `releaseNotes` - Output path to current release notes

[⬅ Return to top](index.md)

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file

## Arguments

- `version` - Optional. String. Version for the release notes path. If not specified uses the current version.

## Examples

    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

## Exit codes

- `1` - if an error occurs

## Environment

BUILD_RELEASE_NOTES
