# Identical Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `identicalRepair` - Repair an identical `token` in `destination` from `source`

Repair an identical `token` in `destination` from `source`

#### Usage

    identicalRepair token source destination
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `identicalCheck` - When, for whatever reason, you need code to match between

When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identicalCheck --extension sh --prefix '# IDENTICAL'

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
should remain identical.

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example. Wink.

#### Usage

    identicalCheck --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success, everything matches
- `100` - Failures

### `identicalCheckShell` - Identical check for shell files

Identical check for shell files

#### Usage

    identicalCheckShell [ --repair repairSource ] [ --help ] [ --interactive ] [ --check checkDirectory ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds
