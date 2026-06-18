### `hookNotify`

> Send a notification

#### Usage

    hookNotify [ --sound soundName ] [ --tags tagList ] [ --priority priority ] [ --title title ] [ --help ] [ --application application ]

Send a notification.

Wrapper for the hook `notify`.

> Location: `bin/build/tools/hooks.sh`

#### Arguments

- `--sound soundName` - String. Optional. Sound name to play. Depends on context of notification.
- `--tags tagList` - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`
- `--priority priority` - String. Optional. Priority of the notification. `low`, or `high`
- `--title title` - String. Optional. Title of the notification.
- `--help` - Flag. Optional. Display this help.
- `--application application` - Directory. Optional. Application home directory.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

