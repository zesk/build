## `textAlignRight`

> align text right

### Usage

    textAlignRight [ characterWidth ] [ text ... ] [ --help ]

Format text and align it right using spaces.

### Arguments

- `characterWidth` - Characters to align right
- `text ...` - Text to align right
- `--help` - Flag. Optional. Display this help.

### Examples

    printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"
    printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

