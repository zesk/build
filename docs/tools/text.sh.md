# Text Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `quoteSedPattern`

Quote a string to be used in a sed pattern on the command line.

### Usage

    quoteSedPattern string

### Arguments

- `string` - A string to quote

### Environment

None.

### Exit codes

- 0 - Always

### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"

# `repeat`

### Usage

    repeat count string

### Arguments

- `count` - An integer greater than or equal to zero
- `string` - A sequence of characters to repeat

### Environment

None.

### Examples

    echo $(repeat 80 =)
    echo Hello world
    echo $(repeat 80 -)

## `echoBar`

Output a bar as wide as the console using the `=` symbol.

### Usage

    echoBar [ alternateChar [ offset ] ]

### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)
### Environment

Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.

### Exit codes

Zero.

### Examples

    consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

## `prefixLines` - Prefix output lines with a string

Prefix output lines with a string, useful to format output or add color codes to consoles which do not honor colors line-by-line. Intended to be used as a pipe.

### Usage

    prefixLines [ text .. ]

### Arguments

- `text` - Text to prefix

### Environment

None.

### Exit codes

0

### Examples

    bigText Success | prefixLines "$(consoleSuccess)"

## `urlParse` - Simple Database URL Parsing

Converts a `url` into values which can be parsed or evaluated:

- `url` - URL
- `host` - Database host
- `user` - Database user
- `password` - Database password
- `port` - Database port
- `name` - Database name


### Usage

    urlParse url

### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection

### Environment

None.

### Exit codes

Zero.

### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

## `urlParseItem` - get a database URL component directly

Gets the component of the URL from a given database URL.

### Usage

    urlParseItem url name

### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection
- `name` - the url component to get: `name`, `user`, `password`, `host`, `port`
### Environment

None.

### Exit codes

Zero.

### Examples

    consoleInfo "Connecting as $(urlParseItem "$url" user)"

## `maximumFieldLength`

### Usage

    maximumFieldLength [ fieldIndex [ separatorChar ] ] < fieldBasedFile

### Arguments

- `fieldIndex` - The field to compute the maximum length for
- `separatorChar` - The separator character to delineate fields
- `fieldBasedFile` - A file with fields

### Environment

None.

### Exit codes

None.

### Examples

    usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;

## `plural` - Output numeric messages which are grammatically accurate

Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.

### Usage

    plural number singular plural

### Arguments

- `number` - A number of nouns you want to describe
- `singular` - The singular form of a noun
- `plural` - The plural form of a noun

### Environment

None.

### Exit codes

Zero.

### Examples

    n=$(($(date +%s)) - start))
    echo "That took $n $(plural "$n" second seconds)"

## `dateToFormat` - Platform agnostic date conversion

Converts a date (`YYYY-MM-DD`) to another format.

### Usage

    dateToFormat date format

### Arguments

- `date` - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
- `format` - Format string for the `date` command (e.g. `%s`)

### Environment

Compatible with BSD and GNU date.

### Exit codes

If parsing fails, non-zero exit code.

### Examples

    timestamp=$(dateToFormat '2023-10-15' %s)

## `dateToTimestamp`

### Usage

    dateToTimestamp date

### Arguments

- `date` - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)

### Environment

Compatible with BSD and GNU date.

### Exit codes

If parsing fails, non-zero exit code.

### Examples

    timestamp=$(dateToTimestamp '2023-10-15')

## `alignRight`

Format text and align it right using spaces.

### Usage

    alignRight characterWidth text [ ... ]

### Arguments

- `characterWidth` - Characters to align right
- `text ...` - Text to align right

### Environment

None

### Exit codes

Zero.

### Examples

    echo "$(alignRight 20 Name:) $name"
    echo "$(alignRight 20 Profession:) $occupation"

Output:

             Name: Juanita
       Profession: Engineer

## `alignLeft`

Format text and align it left using spaces.

### Usage

    alignLeft characterWidth text [ ... ]

### Arguments

- `characterWidth` - Characters to align left
- `text ...` - Text to align left

### Environment

None

### Exit codes

Zero.

### Examples

    echo "$(alignLeft 14 Name:) $name"
    echo "$(alignLeft 14 Profession:) $occupation"

Output:

    Name:          Juanita
    Profession:    Engineer

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)