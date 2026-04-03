## `dateAdd`

> Add or subtract days from a text date

### Usage

    dateAdd [ --days delta ] [ timestamp ... ]

Add or subtract days from a text date

### Arguments

- `--days delta` - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it.
- `timestamp ...` - Date. Timestamp to update.

### Writes to standard output

Date with days added to it

### Examples

    newYearsEve=$(dateAdd --days -1 "2025-01-01")

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

