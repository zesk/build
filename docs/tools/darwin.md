# darwin (Mac OS X) Tools

Tools to work with Darwin, Mac OS X's version of UNIX.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `isDarwin` - Are we on Mac OS X?

Are we on Mac OS X?

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `darwinDialog` - Display a dialog using `osascript` with the choices provided. Typically

Display a dialog using `osascript` with the choices provided. Typically this is found on Mac OS X.
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
### `darwinNotification` - Display a notification for the user

Display a notification for the user

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- `--title` - String. Optional. Title of the notification.
- `--sound` - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Sounds in Darwin

### `darwinSoundDirectory` - Directory for user sounds

Directory for user sounds

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `darwinSoundInstall` - Install a sound file for notifications

Install a sound file for notifications

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `soundFile ...` - File. Required. Sound file(s) to install in user library.
- `--create` - Optional. Flag. Create sound directory if it does not exist.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `darwinSoundNames` - List valid sound names usable for notifications in Darwin

List valid sound names usable for notifications in Darwin

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `darwinSoundValid` - Is a Darwin sound name valid?

Is a Darwin sound name valid?

- Location: `bin/build/tools/darwin.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
