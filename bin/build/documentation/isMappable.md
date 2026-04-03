## `isMappable`

> Check if text contains mappable tokens

### Usage

    isMappable [ --help ] [ --prefix ] [ --suffix ] [ --token ] [ text ]

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--prefix` - String. Optional. Token prefix defaults to `{`.
- `--suffix` - String. Optional. Token suffix defaults to `}`.
- `--token` - String. Optional. Classes permitted in a token
- `text` - String. Optional. Text to search for mapping tokens.

### Return codes

- `0` - Text contains mapping tokens
- `1` - Text does not contain mapping tokens

