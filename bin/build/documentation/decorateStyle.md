## `decorateStyle`

> Get or modify a decoration style

### Usage

    decorateStyle style [ newFormat ]

When `newFormat` is blank, retrieves the format style.
Otherwise sets the new style.

### Arguments

- `style` - String. Required. The style to fetch or replace.
- `newFormat` - String. Optional. The new style formatting options as a string in the form `escapeCodes label`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

