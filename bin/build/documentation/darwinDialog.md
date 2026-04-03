## `darwinDialog`

> Display a dialog using `osascript` with the choices provided. Typically

### Usage

    darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ...

Display a dialog using `osascript` with the choices provided. Typically this is found on Mac OS X.
Outputs the selected button text upon exit.

### Arguments

- `--choice choiceText` - String. Optional. Title of the thing.
- `--ok` - Flag. Optional. Adds "OK" as an option.
- `--cancel` - Flag. Optional. Adds "Cancel" as an option.
- `--default buttonIndex` - Integer. Required. The button (0-based index) to make the default button choice.
- `--help` - Flag. Optional. Display this help.
- `message ...` - String. Required. The message to display in the dialog.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

