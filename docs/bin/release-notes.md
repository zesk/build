
# `release-notes.sh` - Show current release notes

[⬅ Return to top](index.md)

Output the current release notes.

If this fails it outputs an error to stderr

When this tool succeeds it outputs the current release notes file relative to the project root.

## Arguments

- `version` - Optional. String. Version for the release notes path. If not specified uses the current version.

## Examples

open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

## Sample Output

    ./docs/release/v1.0.0.md

## Exit codes

- `1` - if an error occurs
