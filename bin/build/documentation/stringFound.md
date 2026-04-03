## `stringFound`

> Check if one string is a substring of another set

### Usage

    stringFound needle [ haystack ... ]

Check if one string is a substring of another set of strings (case-sensitive)

### Arguments

- `needle` - String. Required. Thing to search for, not blank.
- `haystack ...` - EmptyString. Optional. One or more array elements to match

### Return codes

- `0` - If element is a substring of any haystack
- `1` - If element is NOT found as a substring of any haystack

