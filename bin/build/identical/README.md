# Identical directory

This directory is the `source` for most Identical templates.

Code in here is never loaded or run, but it typically copied to other files using the `identicalRepair` or
`bin/build/repair.sh` tool.

Ordering matters, and files are sorted so files beginning with `_` (or `__`) are loaded FIRST and will have the master
version of the template which will be used.

Some identical tags are less frequently used (`__IDENTICAL__` and `_IDENTICAL_` and `DOC TEMPLATE:`) so run
`bin/build/repair.sh` with the `--internal` flag regularly to ensure all templates are kept up to date.

The identical repair is part of the build process and typically should not change anything during that step.
