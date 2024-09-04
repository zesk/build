# darwin (Mac OS X) Tools

Tools to work with Darwin, Mac OS X's version of UNIX.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `darwinDialog` - Display a dialog using `osascript` with the choices provided. Typically

Display a dialog using `osascript` with the choices provided. Typically this is found in Darwin, Mac OS X's operating system.
Outputs the selected button text upon exit.

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--choice choiceText` - Optional. String. Title of the thing.
- `--ok` - Optional. Flag. Adds "OK" as an option.
- `--cancel` - Optional. Flag. Adds "Cancel" as an option.
- `--default buttonIndex` - Required. Integer. The button (0-based index) to make the default button choice.
- `message ...` - Required. String. The message to display in the dialog.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
