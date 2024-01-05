# Text Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `quoteSedPattern` - Quote sed strings for shell use

Quote a string to be used in a sed pattern on the command line.

#### Usage

    quoteSedPattern text

#### Arguments

- `text` - Text to quote

#### Examples

sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"

#### Sample Output

    string quoted and appropriate to insert in a sed search or replacement phrase

#### Exit codes

- `0` - Always succeeds

### `quoteBashString` - Quote bash strings for inclusion as single-quoted for eval

Quote bash strings for inclusion as single-quoted for eval

#### Usage

    quoteBashString text

#### Arguments

- `text` - Text to quote

#### Examples

name="$(quoteBashString "$name")"

#### Sample Output

    string quoted and appropriate to assign to a value in the shell

#### Exit codes

- `0` - Always succeeds

#### Depends

    sed


### `escapeQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

#### Usage

    escapeSingleQuotes text

#### Arguments

- `text` - Text to quote

#### Examples

escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash

#### Exit codes

- `0` - Always succeeds

### `escapeSingleQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

#### Usage

    escapeSingleQuotes text

#### Arguments

- `text` - Text to quote

#### Examples

escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash

#### Exit codes

- `0` - Always succeeds

### `escapeDoubleQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

#### Usage

    escapeSingleQuotes text

#### Arguments

- `text` - Text to quote

#### Examples

escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash

#### Exit codes

- `0` - Always succeeds

### `replaceFirstPattern` - Replaces the first and only the first occurrence of a

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.

#### Usage

    replaceFirstPattern pattern replacement

#### Exit codes

- `0` - Always succeeds


### `trimWords` - Remove words from the end of a phrase

Remove words from the end of a phrase

#### Usage

    trimWords [ wordCount [ word0 ... ] ]

#### Arguments

- `wordCount` - Words to output
- `word0` - One or more words to output

#### Examples

printf "%s: %s
" "Summary:" "$(trimWords 10 $description)"

#### Exit codes

- `0` - Always succeeds

### `trimSpace` - Trim whitespace of a bash argument

Trim spaces and only spaces

#### Usage

    trimSpace text

#### Arguments

- `text` - Text to remove spaces

#### Examples

trimSpace "$token"

#### Sample Output

    text

#### Exit codes

- `0` - Always succeeds

#### Credits

Thanks to [Chris F.A. Johnson (2008)](https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816).

### `trimSpacePipe` - Trim whitespace in a pipeline

Strip whitespace in input stream
Removes leading and trailing spaces in input, also removes blank lines I think

#### Usage

    trimSpacePipe < file > output

#### Arguments

- None

#### Exit codes

- `0` - Always succeeds

#### Depends

    awk


### `stringOffset` - Outputs the integer offset of `needle` if found as substring

Outputs the integer offset of `needle` if found as substring in `haystack`
If `haystack` is not found, -1 is output

#### Usage

    stringOffset needle haystack

#### Exit codes

- `0` - Always succeeds

### `maximumFieldLength` - Given a input file, determine the maximum length of fieldIndex,

Given a input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields

Defaults to first field (fieldIndex=1), space separator (separatorChar=" ")

#### Usage

    maximumFieldLength [ fieldIndex [ separatorChar ] ] < fieldBasedFile

#### Arguments

- `fieldIndex` - The field to compute the maximum length for
- `separatorChar` - The separator character to delineate fields
- `fieldBasedFile` - A file with fields

#### Examples

usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;

#### Exit codes

- `0` - Always succeeds

## Types


### `inArray` - Check if an element exists in an array

Check if an element exists in an array

#### Usage

    inArray element [ arrayElement0 arrayElement1 ... ]

#### Arguments

- `element` - Thing to search for
- `arrayElement0` - One or more array elements to match

#### Exit codes

- `0` - If element is found in array
- `1` - If element is NOT found in array

### `isUnsignedNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number

#### Usage

    isInteger argument

#### Exit codes

- `0` - if it is an integer
- `1` - if it is not an integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number

#### Usage

    isInteger argument

#### Exit codes

- `0` - if it is an integer
- `1` - if it is not an integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isInteger` - Test if an argument is a signed integer

Test if an argument is a signed integer

#### Usage

    isInteger argument

#### Exit codes

- `0` - if it is a signed integer
- `1` - if it is not a signed integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isuint_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isUnsignedInteger` - Test if an argument is an unsigned integer

Test if an argument is an unsigned integer

#### Exit codes

- `0` - if it is an unsigned integer
- `1` - if it is not an unsigned integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number

#### Usage

    isInteger argument

#### Exit codes

- `0` - if it is an integer
- `1` - if it is not an integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

## Language-related


### `plural` - Outputs the `singular` value to standard out when the value

Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.


Example:

#### Usage

    plural number singular plural

#### Arguments

- `number` - An integer or floating point number
- `singular` - The singular form of a noun
- `plural` - The plural form of a noun

#### Examples

count=$(($(wc -l < $foxSightings) + 0))
    printf "We saw %d %s.
" "$count" "$(plural $count fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(plural "$n" second seconds)"

#### Exit codes

- `1` - If count is non-numeric
- `0` - If count is numeric

## Decoration


#### Usage

    repeat count string [ ... ]

#### Arguments

- `count` - Required, integer count of times to repeat
- `string` - A sequence of characters to repeat
- `...` - Additional arguments are output using shell expansion of `$*`

#### Examples

echo $(repeat 80 =)
    echo Hello world
    echo $(repeat 80 -)

#### Exit codes

- `0` - Always succeeds

### `echoBar` - Output a bar as wide as the console using the

Output a bar as wide as the console using the `=` symbol.

#### Usage

    echoBar [ alternateChar [ offset ] ]

#### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)

#### Examples

consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

#### Exit codes

- `0` - Always succeeds

#### Environment

Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.

### `prefixLines` - Prefix output lines with a string

Prefix output lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

#### Usage

    prefixLines [ text .. ] < fileToPrefixLines

#### Arguments

- `text` - Prefix each line with this text

#### Examples

cat "$file" | prefixLines "$(consoleCode)"
    cat "$errors" | prefixLines "    ERROR: "

#### Exit codes

- 0

### `alignRight` - align text right

Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.


Example:


Format text and align it right using spaces.

#### Usage

    alignRight characterWidth text [ ... ]

#### Arguments

- `characterWidth` - Characters to align right
- `text ...` - Text to align right

#### Examples

printf "%s: %s
" "$(alignRight 20 Name)" "$name"
    printf "%s: %s
" "$(alignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer

#### Exit codes

- `1` - If count is non-numeric
- `0` - If count is numeric

### `alignLeft` - align text left

Format text and align it left using spaces.

#### Usage

    alignLeft characterWidth text [ ... ]

#### Arguments

- `characterWidth` - Characters to align left
- `text ...` - Text to align left

#### Examples

printf "%s: %s
" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s
" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer

#### Exit codes

- `0` - Always succeeds

### `boxedHeading` - Text heading decoration

Heading for section output

#### Usage

    boxedHeading [ --size size ] text [ ... ]

#### Arguments

- `--size size` - Number of liens to output
- `text ...` - Text to put in the box

#### Examples

boxedHeading Moving ...

#### Sample Output

    +================================================================================================+
    |                                                                                                |
    | Moving ...                                                                                     |
    |                                                                                                |
    +================================================================================================+

#### Exit codes

- `0` - Always succeeds

## Transformation


### `lowercase` - Convert text to lowercase

Convert text to lowercase

#### Usage

    lowercase [ text ... ]

#### Exit codes

- `0` - Always succeeds

### `shaPipe` - SHA1 checksum of standard input

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

#### Usage

    shaPipe [ filename ... ]

#### Arguments

- `filename` - One or more filenames to generate a checksum for

#### Examples

shaPipe < "$fileName"
    shaPipe "$fileName0" "$fileName1"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b

#### Exit codes

- `0` - Always succeeds

#### Environment

DEBUG_SHAPIPE - When set to a truthy value, will output all requested shaPipe calls to log called `shaPipe.log`.

#### Depends

    shasum

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
