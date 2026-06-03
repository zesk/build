## `__BUILD_HAS_TTY`

> **TTY Cached Result** &mdash; Cached value of the availability of `/dev/tty`.
> > **Type**: *Boolean* • **Category**: *Internal*

Cached value of the availability of `/dev/tty`.
Possible values are `true` or `false` or blank.

- `true` - `/dev/tty` appears to be operating without errors
- `false` - `/dev/tty` appears to be disconnected and can not be used

This value is set automatically by `isTTYAvailable` and caches the value using this environment variable to avoid testing again.

