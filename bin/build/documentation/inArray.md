## `inArray`

> Check if an element exists in an array

### Usage

    inArray [ element ] [ arrayElement0 ... ]

Check if an element exists in an array
Without arguments, displays help.

### Arguments

- `element` - EmptyString. Thing to search for
- `arrayElement0 ...` - Array. Optional. One or more array elements to match

### Examples

    if inArray "$thing" "${things[@]+"${things[@]}"}"; then
        things+=("$thing")
    fi

### Return codes

- `0` - If element is found in array
- `1` - If element is NOT found in array

