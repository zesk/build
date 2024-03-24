
# `releaseNotes` - Output path to current release notes

[⬅ Return to top](index.md)

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file

## Usage

    releaseNotes [ version ]
    

## Arguments



## Examples

    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

## Exit codes

- `1` - if an error occurs

## Environment

BUILD_RELEASE_NOTES
