
# `cannon.sh` - Replace text `fromText` with `toText` in files, using `findArgs` to

[⬅ Return to top](index.md)

Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.

This can break your files so use with caution.

## Usage

    cannon fromText toText [ findArgs ... ]

## Arguments

- `fromText` - Required. String of text to search for.
- `toText` - Required. String of text to replace.
- `findArgs ...` - Any additional arguments are meant to filter files.

## Examples

    cannon master main ! -path '*/old-version/*')

## Exit codes

- `0` - Success
- `1` - Arguments are identical
