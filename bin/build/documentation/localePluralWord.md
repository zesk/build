## `localePluralWord`

> Plural word which includes the numeric prefix and the noun.

### Usage

    localePluralWord number singular [ localePlural ]

Plural word which includes the numeric prefix and the noun.

### Arguments

- `number` - Number. Required. An integer or floating point number
- `singular` - String. Required. The singular form of a noun
- `localePlural` - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.

### Writes to standard output

`String`. The number (direct) and the localePlural form for non-1 values. e.g. `$(localePluralWord 2 potato potatoes)` = `2 potatoes`

### Examples

    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %s.\n" "$(localePluralWord "$count" fox foxes)"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

