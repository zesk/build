## `serviceToPort`

> Get the port number associated with a service

### Usage

    serviceToPort service [ --services servicesFile ] [ --help ]

Get the port number associated with a service

### Arguments

- `service` - String. Required. A unix service typically found in `/etc/services`
- `--services servicesFile` - File. Optional. File like '/etc/services`.
- `--help` - Flag. Optional. Display this help.

### Sample Output

Port number of associated service (integer) one per line

### Return codes

- `1` - service not found
- `2` - bad argument or invalid port
- `0` - service found and output is an integer

