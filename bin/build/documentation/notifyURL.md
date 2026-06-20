### `notifyURL`

> Send a notification by submitting data to a URL

#### Usage

    notifyURL [ --tags tagList ] [ --priority priority ] [ --title title ] [ --response responseHandler ] [ --handler handler ] [ --help ]

Send a notification by submitting data to a URL

> Location: `bin/build/tools/notify.sh`

#### Arguments

- `--tags tagList` - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`
- `--priority priority` - String. Optional. Priority of the notification. `low`, or `high`
- `--title title` - String. Optional. Title of the notification.
- `--response responseHandler` - Function. Optional. Use this handler to parse the result and output a response ID.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`NOTIFY_URL` Notification URL]({rel}env/#notify) – **URL**. URL to send default notifications
- [`NOTIFY_URL_AUTHORIZATION` Notification URL Authorization Token]({rel}env/#notify) – **Secret**. Authorization token for default notifications.

