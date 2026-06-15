### `isUnsignedInteger`

> Is value an unsigned integer?

#### Usage

    isUnsignedInteger [ value ]

Test if a value is a 0 or greater integer. Leading "+" is ok.



> Location: `bin/build/tools/example.sh`

#### Arguments

- `value` - EmptyString. Value to test if it is an unsigned integer.

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `0` - if it is an unsigned integer
- `1` - if it is not an unsigned integer

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires



#### See Also

- [stackoverflow.com](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash)

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/example.sh`, function `isUnsignedInteger` was reviewed {reviewed}.

#### Errors

{error}
