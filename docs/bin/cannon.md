
# `cannon` - Replace text `fromText` with `toText` in files, using `findArgs` to

[⬅ Return to top](index.md)

Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.

This can break your files so use with caution. Blank searchText is not allowed.

## Usage

    cannon [ --path directory ] [ --help ] fromText toText [ findArgs ... ]
    

## Arguments



## Examples

    cannon master main ! -path '*/old-version/*')

## Exit codes

- `0` - Success
- `1` - --path is not a directory
- `1` - searchText is not blank
- `1` - mktemp failed
- `2` - Arguments are identical

## See Also

- [Source {fn}]({sourceLink})
