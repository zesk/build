## `stringContains`

> Find whether a substring exists in one or more strings

### Usage

    stringContains haystack [ needle ... ]

Does needle exist as a substring of haystack?

### Arguments

- `haystack` - String. Required. String to search.
- `needle ...` - String. Optional. One or more strings to find as a substring of `haystack`.

### Return codes

- `0` - IFF ANY needle matches as a substring of haystack
- `1` - No needles found in haystack

