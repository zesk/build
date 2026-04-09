## `stringBeginsInsensitive`

> Find whether a substring exists as teh beginning of one or more strings

### Usage

    stringBeginsInsensitive haystack [ needle ... ]

Does needle exist as a substring of haystack? (case-insensitive)

### Arguments

- `haystack` - String. Required. String to search. (case-insensitive)
- `needle ...` - String. Optional. One or more strings to find as the "start" of `haystack` (case-insensitive)

### Return codes

- `0` - IFF ANY needle matches as a substring of haystack (case-insensitive)
- `1` - No needles found in haystack (case-insensitive)

