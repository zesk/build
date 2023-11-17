# Text Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `quoteSedPattern` - Quote sed strings for shell use

Quote a string to be used in a sed pattern on the command line.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    quoteSedPattern text

### Arguments

- `text` - Text to quote

### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"

### Sample Output

string quoted and appropriate to insert in a sed search or replacement phrase

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `repeat` - 



(Located at: `./bin/build/tools/text.sh`)

### Usage

    repeat count string [ ... ]

### Arguments

`count` - Required, integer count of times to repeat
`string` - A sequence of characters to repeat
- `...` - Additional arguments are output using shell expansion of `$*`

### Examples

    echo $(repeat 80 =)
    echo Hello world
    echo $(repeat 80 -)

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `echoBar` - 

Output a bar as wide as the console using the `=` symbol.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    echoBar [ alternateChar [ offset ] ]

### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)

### Examples

    consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `prefixLines` - Prefix output lines with a string

Prefix output lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    prefixLines [ text .. ] < fileToPrefixLines

### Arguments

`text` - Prefix each line with this text

### Examples

    cat "$file" | prefixLines "$(consoleCode)"
    cat "$errors" | prefixLines "    ERROR: "

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `trimSpace` - Trim whitespace of a bash argument

Trim spaces and only spaces

(Located at: `./bin/build/tools/text.sh`)

### Usage

    trimSpace text

### Arguments

- `text` - Text to remove spaces

### Examples

    trimSpace "$token"

### Sample Output

text

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Credits

Thanks to [Chris F.A. Johnson (2008)](https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816).

## `urlParse` - Simple Database URL Parsing

Simplistic URL parsing. Converts a `url` into values which can be parsed or evaluated:

- `url` - URL
- `host` - Database host
- `user` - Database user
- `password` - Database password
- `port` - Database port
- `name` - Database name

(Located at: `./bin/build/tools/text.sh`)

### Usage

    urlParse url

### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection

### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `urlParseItem` - Get a database URL component directly

Gets the component of the URL from a given database URL.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    urlParseItem url name

### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection
- `name` - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`

### Examples

    consoleInfo "Connecting as $(urlParseItem "$url" user)"

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `maximumFieldLength` - 

Given a input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields

Defaults to first field (fieldIndex=1), space separator (separatorChar=" ")

(Located at: `./bin/build/tools/text.sh`)

### Usage

    maximumFieldLength [ fieldIndex [ separatorChar ] ] < fieldBasedFile

### Arguments

- `fieldIndex` - The field to compute the maximum length for
- `separatorChar` - The separator character to delineate fields
- `fieldBasedFile` - A file with fields

### Examples

    usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `escapeDoubleQuotes` - 

Quote strings for inclusion in shell quoted strings

(Located at: `./bin/build/tools/text.sh`)

### Usage

    escapeSingleQuotes text

### Arguments

- `text` - Text to quote

### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `plural` - Output numeric messages which are grammatically accurate

Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.


Example:

(Located at: `./bin/build/tools/text.sh`)

### Usage

    plural number singular plural

### Arguments

- `number` - An integer or floating point number
- `singular` - The singular form of a noun
- `plural` - The plural form of a noun

### Examples

    count=$(($(wc -l < $foxSightings) + 0))
    printf "We saw %d %s.
" "$count" "$(plural $count fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(plural "$n" second seconds)"

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications. 

## `escapeSingleQuotes` - 

Quote strings for inclusion in shell quoted strings

(Located at: `./bin/build/tools/text.sh`)

### Usage

    escapeSingleQuotes text

### Arguments

- `text` - Text to quote

### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `escapeQuotes` - 

Quote strings for inclusion in shell quoted strings

(Located at: `./bin/build/tools/text.sh`)

### Usage

    escapeSingleQuotes text

### Arguments

- `text` - Text to quote

### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `stripWhitespace` - Trim whitespace in a pipeline

Strip whitespace in input stream
Removes leading and trailing spaces in input, also removes blank lines I think

(Located at: `./bin/build/tools/text.sh`)

### Usage

    stripWhitespace < file > output

### Arguments

- None

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Depends

    awk 

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.


## `dateToTimestamp` - 

Converts a date to an integer timestamp

(Located at: `./bin/build/tools/text.sh`)

### Usage

    dateToTimestamp date

### Arguments

- `date` - String in the form `- `YYYY` - - `MM` - DD` (e.g. `- `2023` - - `10` - 15`)

### Examples

    timestamp=$(dateToTimestamp '2023-10-15')

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.


## `echoBar` - 

Output a bar as wide as the console using the `=` symbol.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    echoBar [ alternateChar [ offset ] ]

### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)

### Examples

    consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.


### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `prefixLines` - Prefix output lines with a string

Prefix output lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    prefixLines [ text .. ] < fileToPrefixLines

### Arguments

`text` - Prefix each line with this text

### Examples

    cat "$file" | prefixLines "$(consoleCode)"
    cat "$errors" | prefixLines "    ERROR: "

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.


## `alignRight` - align text right

Format text and align it right using spaces.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    alignRight characterWidth text [ ... ]

### Arguments

`characterWidth` - Characters to align right
`text ...` - Text to align right

### Examples

    printf "%s: %s
" "$(alignRight 20 Name)" "$name"
    printf "%s: %s
" "$(alignRight 20 Profession)" "$occupation"
                    Name: Juanita
              Profession: Engineer

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `alignLeft` - align text left

Format text and align it left using spaces.

(Located at: `./bin/build/tools/text.sh`)

### Usage

    alignLeft characterWidth text [ ... ]

### Arguments

- - `characterWidth` - Characters to align left
- `text ...` - Text to align left

### Examples

    printf "%s: %s
" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s
" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.


## `lowercase` - 

Convert text to lowercase

(Located at: `./bin/build/tools/text.sh`)

### Usage

    lowercase [ text ... ]

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `boxedHeading` - Text heading decoration

Heading for section output

(Located at: `./bin/build/tools/text.sh`)

### Usage

    boxedHeading text [ ... ]

### Arguments

- `text ...` - Text to put in the box

### Examples

    boxedHeading Moving ...

### Sample Output

+================================================================================================+
|                                                                                                |
| Moving ...                                                                                     |
|                                                                                                |
+================================================================================================+

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `shaPipe` - SHA1 checksum of standard input



(Located at: `./bin/build/tools/text.sh`)

### Usage

    shaPipe [ ... ]

### Examples

    shaPipe < "$fileName"

### Sample Output

cf7861b50054e8c680a9552917b43ec2b9edae2b

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Depends

    shasum

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
