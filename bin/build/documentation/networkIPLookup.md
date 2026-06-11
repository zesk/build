### `networkIPLookup`

> Get the current IP address of a host

#### Usage

    networkIPLookup [ --help ]

Get the current IP address of a host

> Location: `bin/build/tools/network.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`IP_URL` IP Lookup URL]({rel}/env/#build_configuration) – **URL**. URL to look up IP my address remotely
- [`IP_URL_FILTER` Filter for IP Lookup]({rel}/env/#build_configuration) – **String**. jq filter to parse IP_URL result (assuming JSON)

