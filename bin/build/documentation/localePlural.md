## `localePlural`

> Outputs the `singular` value to standard out when the value

### Usage

    localePlural number singular [ localePlural ]

Outputs the `singular` value to standard out when the value of `number` is one.
Otherwise, outputs the `localePlural` value to standard out.
Example:

### Arguments

- `number` - Number. Required. An integer or floating point number
- `singular` - String. Required. The singular form of a noun
- `localePlural` - String. Optional. The localePlural form of a noun. If not specified uses `singular` plus an ess.

### Writes to standard output

`String`. The localePlural form for non-1 values. e.g. `$(localePlural 2 potato potatoes)` = `potatoes`

### Examples

    count=$(fileLineCount "$foxSightings") || return $?
    printf "We saw %d %s.\n" "$count" "$(localePlural "$count" fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(localePlural "$n" second seconds)"

### Return codes

- `1` - If count is non-numeric
- `0` - If count is numeric

