## `BUILD_MAINTENANCE_MESSAGE_VARIABLE`

> **Maintenance Variable Message Name** &mdash; Name of the environment variable (if any) which reflects the
> > **Type**: *EnvironmentVariable* • **Category**: *Application*

Name of the environment variable (if any) which reflects the current maintenance message.
Default is `MAINTENANCE_MESSAGE` and this is typically added to the `.env.local` to a live
application. Your application should monitor these files for changes if they are cached and reload as needed to ensure
these messages are displayed immediately.

