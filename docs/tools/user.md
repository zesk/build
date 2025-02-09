# user Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `userHome` - The current user HOME (must exist)

The current user HOME (must exist)
No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.

- Location: `bin/build/tools/user.sh`

#### Arguments

- `pathSegment` - String. Optional. Add these path segments to the HOME directory returned. Does not create them.

#### Exit codes

- `1` - Issue with `buildEnvironmentGet HOME` or $HOME is not a directory (say, it's a file)
- `0` - Home directory exists.
