# Text Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Patterns


### `isCharacterClass` - Poor-man's bash character class matching

Poor-man's bash character class matching

Returns true if all `characters` are of `className`

`className` can be one of:
    alnum   alpha   ascii   blank   cntrl   digit   graph   lower
    print   punct   space   upper   word    xdigit

#### Exit codes

- `0` - Always succeeds

## Filters


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

### `escapeBash` - Converts strings to shell escaped strings

Converts strings to shell escaped strings

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

    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"

#### Exit codes

- `0` - Always succeeds

### `trimSpace` - Trim whitespace of a bash argument

Trim spaces and only spaces from arguments or a pipe

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

trimSpace handles both cases now.

#### Usage

    trimSpace < file > output
    

#### Exit codes

- `0` - Always succeeds

#### Depends

    awk
    

#### See Also

- [function trimSpace
](./docs/tools/text.md
) - [Trim whitespace of a bash argument
](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L111
)

### `stripAnsi` - Strip ANSI console escape sequences from a file

Strip ANSI console escape sequences from a file

#### Usage

    stripAnsi < input > output
    

#### Arguments

- None.

#### Exit codes

- `0` - Always succeeds

#### Local cache

None.

#### Environment

None.

#### Depends

    sed
    

#### Credits

Thanks to [commandlinefu tripleee](https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc).


### `listTokens` - listTokens

listTokens

#### Usage

    listTokens prefix suffix < input > output
    

#### Arguments

- `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
- `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)

#### Exit codes

- `0` - Always succeeds

#### Local cache

None.

#### Environment

None.

#### Depends

    sed quoteSedPattern
    


### `mapValue` - Maps a string using an environment file

Maps a string using an environment file

#### Usage

    mapValue mapFile [ value ... ]
    

#### Arguments

- `mapFile` - a file containing bash environment definitions
- `value` - One or more values to map using said environment file

#### Exit codes

- `0` - Always succeeds

### `mapValueTrim` - Maps a string using an environment file

Maps a string using an environment file

#### Usage

    mapValue mapFile [ value ... ]
    

#### Arguments

- `mapFile` - a file containing bash environment definitions
- `value` - One or more values to map using said environment file

#### Exit codes

- `0` - Always succeeds

## Finding or Calculating


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
    printf "We saw %d %s.\n" "$count" "$(plural $count fox foxes)"
    n=$(($(date +%s)) - start))
    printf "That took %d %s" "$n" "$(plural "$n" second seconds)"

#### Exit codes

- `1` - If count is non-numeric
- `0` - If count is numeric

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
    

### `cachedShaPipe` - SHA1 checksum of standard input

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

Speeds up shaPipe using modification dates of the files instead.

The cacheDirectory

#### Usage

    cachedShaPipe cacheDirectory [ filename ]
    

#### Arguments

- `cacheDirectory` - The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.

#### Examples

    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Always succeeds

#### Depends

    shasum
    

### `cannon.sh` - Replace text `fromText` with `toText` in files, using `findArgs` to

Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.

This can break your files so use with caution.

#### Arguments

- `fromText` - Required. String of text to search for.
- `toText` - Required. String of text to replace.
- `findArgs ...` - Any additional arguments are meant to filter files.

#### Examples

    cannon master main ! -path '*/old-version/*')

#### Exit codes

- `0` - Success
- `1` - Arguments are identical

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
