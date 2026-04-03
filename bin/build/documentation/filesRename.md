## `filesRename`

> Rename a list of files usually to back them up temporarily

### Usage

    filesRename oldSuffix newSuffix actionVerb file ...

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb
If files do not exist, does nothing
Used to move files, temporarily, sometimes and then move back easily.
Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

### Arguments

- `oldSuffix` - String. Required. Old suffix to look rename from.
- `newSuffix` - String. Required. New suffix to rename to.
- `actionVerb` - String. Required. Description to output for found files.
- `file ...` - String. Required. One or more files to rename, if found, renaming occurs.

### Examples

    filesRename "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    filesRename ".$$.backup" "" restoring etc/app.json etc/config.json

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

