# Utilites Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `incrementor` - Set or increment a process-wide incrementor. If no numeric value

Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it.
New values are set to 0 by default so will output `1` upon first usage.
If no variable name is supplied it uses the default variable name `default`.

Variable names can contain alphanumeric characters, underscore, or dash.

Sets `default` incrementor to 1 and outputs `1`

    incrementor 1

Increments the `kitty` counter and outputs `1` on first call and `n + 1` for each subsequent call.

    incrementor kitty

Sets `kitty` incrementor to 2 and outputs `2`

    incrementor 2 kitty


#### Usage

    incrementor [ count | variable ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Depends

    buildCacheDirectory
    

#### See Also

{SEE:buildCacheDirectory}

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
