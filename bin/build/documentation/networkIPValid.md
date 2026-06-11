### `networkIPValid`

> Is a network IP valid?

#### Usage

    networkIPValid [ --help ] [ ip ]

Must be valid IPv4 or IPv6 address.

> Location: `bin/build/tools/network.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `ip` - String. IP to test for validity.

#### Reads standard input

line:String - Network IPs to test for validity.

#### Return codes

- `0` - All network IPs passed in are valid.
- `1` - One or more network IPs passed in are not valid

