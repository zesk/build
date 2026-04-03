### Usage

    hookRun maintenance maintenanceSetting [ --message maintenanceMessage ]

Toggle maintenance on or off. The default version of this modifies the environment files for the application by modifying the `.env.local` file
and dynamically adding or removing any line which matches the MAINTENANCE variable.
Note that applications SHOULD load this configuration file dynamically (and monitor it for changes) to enable maintenance at any time.

### Arguments

- `maintenanceSetting` - String. Required. Maintenance setting: `on | 1 | true | enable | off | 0 | false | disable`
- `--message maintenanceMessage` - String. Optional. Message to display to the use as to why maintenance is enabled.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_MAINTENANCE_VARIABLE.sh} - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.

