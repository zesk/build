## `gitHasAnyRefs`

> Does git have any tags?

### Usage

    gitHasAnyRefs [ --help ]

Do any tags exist at all in `git`?
May need to `git pull --tags`, or no tags exist.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - At least one tag exists
- `1` - No tags exist

