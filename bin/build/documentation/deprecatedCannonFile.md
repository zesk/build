## `deprecatedCannonFile`

> Run cannon using a configuration file or files.

### Usage

    deprecatedCannonFile findArgumentFunction cannonFile

Run cannon using a configuration file or files.
Comment lines (First character is `#`) are considered the current "state" (e.g. version) and are displayed during processing.
Sample file:
    # v0.25.0
    timingStart|timingStart
    timingReport|timingReport
    bashUserInput|bashUserInput
    # v0.24.0
    listJoin|listJoin
    mapTokens|mapTokens

### Arguments

- `findArgumentFunction` - Function. Required. Find arguments (for `find`) for cannon.
- `cannonFile` - File. Required. One or more files delimited with `|` characters, one per line `search|replace|findArguments|...`. If not files are supplied then pipe file via stdin.

### Return codes

- `0` - No changes were made in any files.
- `1` - changes were made in at least one file.

