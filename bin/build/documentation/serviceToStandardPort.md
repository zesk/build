### `serviceToStandardPort`

> Handle standard services

#### Usage

    serviceToStandardPort [ --help ] [ service ... ]

Hard-coded services for:

- `ssh` -> 22
- `http`-> 80
- `https`-> 80
- `postgres`-> 5432
- `mariadb`-> 3306
- `mysql`-> 3306

Backup when `/etc/services` does not exist.

> Location: `bin/build/tools/platform.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `service ...` - String. Optional. A unix service typically found in `/etc/services`

#### Sample Output

Port number of associated service (integer) one per line

#### Return codes

- `1` - service not found
- `0` - service found and output is an integer

#### See Also

- [serviceToPort]({rel}tools/service.md#servicetoport) - Get the port number associated with a service ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L263))

