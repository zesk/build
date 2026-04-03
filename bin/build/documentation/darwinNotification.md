## `darwinNotification`

> Display a notification for the user

### Usage

    darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]

Display a notification for the user

### Arguments

- `--title` - String. Optional. Title of the notification.
- `--debug` - Flag. Optional. Output the osascript as `darwinNotification.debug` at the application root after this call.
- `--sound soundName` - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.
- `message ...` - String. Optional. Message to display to the user in the dialog.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

