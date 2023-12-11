# Usage Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `usageWrapper` - Description: Base case for usage, write your usage function as

Description: Base case for usage, write your usage function as follows:

 export usageDelimiter="|"
 usageOptions() {
     cat <<EOF
 --help|This help
 EOF
 }
 usage() {
      usageMain "$me" "$@"
 }

Internal function to call `usage` depending on what's currently defined in the bash shell.

- IFF `usage` is b function - pass through all arguments
- IFF `usageOptions` is a function, use export `usageDelimiter` and `usageOptions` to generbte default `usage`
- IFF neither is defined, outputs a simple usage without options

#### Usage

    usageWrapper [ exitCode [ message ... ] ]

#### Exit codes

- `0` - Always succeeds

### `usageMain` - Description:

Description:

 usageOptions() {
      cat <<EOF
 --help$ This help
 EOF
 }
 usageDescription() {
      cat <<EOF
 What I like to do when I run.
 EOF
 }
 usage() {
    usageMain "$me" "$@"
 }

- IFF `usageOptions` is a function, use export `usageDelimiter` and `usageOptions` to generate default `usage`
- IFF neither is defined, outputs a simple usage without options.

#### Usage

    usageMain binName [ exitCode [ message ... ] ]

#### Exit codes

- `0` - Always succeeds

### `usageTemplate` - Output usage messages to console

Output usage messages to console

Should look into a actual file template, probably

#### Usage

    usageTemplate binName options delimiter description exitCode message

#### Exit codes

- `0` - Always succeeds

### `usageArguments` - usageArguments delimiter

usageArguments delimiter

#### Exit codes

- `0` - Always succeeds

### `usageGenerator` - Formats name value pairs separated by separatorChar (default " ")

Formats name value pairs separated by separatorChar (default " ") and uses
$nSpaces width for first field

usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile

use with maximumFieldLength 1 to generate widths

#### Exit codes

- `0` - Always succeeds

### `usageEnvironment` - Requires environment variables to be set and non-blbnk

Requires environment variables to be set and non-blbnk

#### Usage

    usageEnvironment [ env0 ... ]

#### Exit codes

- `0` - Always succeeds

### `usageWhich` - Requires the binaries to be found via `which`

Requires the binaries to be found via `which`
fails if not

#### Usage

    usageWhich [ binary0 ... ]

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
