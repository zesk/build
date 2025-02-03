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

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Filters

### `sedReplacePattern` - Quote a sed command for search and replace

Quote a sed command for search and replace

- Location: `bin/build/tools/sed.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `quoteSedPattern` - Quote sed search strings for shell use

Quote a string to be used in a sed pattern on the command line.

- Location: `bin/build/identical/quoteSedPattern.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
    needSlash=$(quoteSedPattern '$.*/[\]^')

#### Sample Output

    string quoted and appropriate to insert in a sed search or replacement phrase
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `quoteSedReplacement` - Quote sed replacement strings for shell use

Quote sed replacement strings for shell use

- Location: `bin/build/identical/quoteSedPattern.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
    needSlash=$(quoteSedPattern '$.*/[\]^')

#### Sample Output

    string quoted and appropriate to insert in a sed search or replacement phrase
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `quoteBashString` - Quote bash strings for inclusion as single-quoted for eval

Quote bash strings for inclusion as single-quoted for eval

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    name="$(quoteBashString "$name")"

#### Sample Output

    string quoted and appropriate to assign to a value in the shell
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    sed
    
### `quoteGrepPattern` - Quote grep -e patterns for shell use

Quote grep -e patterns for shell use

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"

#### Sample Output

    string quoted and appropriate to insert in a grep search or replacement phrase
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `escapeQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `escapeSingleQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `escapeDoubleQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to quote

#### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `escapeBash` - Converts strings to shell escaped strings

Converts strings to shell escaped strings

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `replaceFirstPattern` - Replaces the first and only the first occurrence of a

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `removeFields` - Remove fields from left to right from a text file

Remove fields from left to right from a text file as a pipe

- Location: `bin/build/tools/text.sh`

#### Arguments

- `fieldCount` - Optional. Integer. Number of field to remove. Default is just first `1`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `stripAnsi` - Strip ANSI console escape sequences from a file

Strip ANSI console escape sequences from a file

- Location: `bin/build/tools/text.sh`

#### Arguments

- None.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

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

- Location: `bin/build/tools/text.sh`

#### Arguments

- `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
- `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

None.

#### Environment

None.

#### Depends

    sed quoteSedPattern
    

### `isMappable` - Check if text contains mappable tokens

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--prefix` - Optional. String. Token prefix defaults to `{`.
- `--suffix` - Optional. String. Token suffix defaults to `}`.
- `--token` - Optional. String. Classes permitted in a token
- `text` - Optional. String. Text to search for mapping tokens.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mapValue` - Maps a string using an environment file

Maps a string using an environment file

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `mapFile` - Required. File. a file containing bash environment definitions
- `value` - Optional. String. One or more values to map using said environment file
- `--prefix` - Optional. String. Token prefix defaults to `{`.
- `--suffix` - Optional. String. Token suffix defaults to `}`.
- `--search-filter` - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
- `--replace-filter` - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mapValueTrim` - Maps a string using an environment file

Maps a string using an environment file

- Location: `bin/build/tools/text.sh`

#### Arguments

- `mapFile` - Required. File. a file containing bash environment definitions
- `value` - Optional. String. One or more values to map using said environment file.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `environmentName` - Optional. String. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - Optional. String. Prefix character for tokens, defaults to `{`.
- `--suffix` - Optional. String. Suffix character for tokens, defaults to `}`.
- `--help` - Optional. Flag. Display this help.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Argument-passed or entire environment variables which are exported are used and mapped to the destination.

### `printfOutputPrefix` - Pipe to output some text before any output, otherwise, nothing

Pipe to output some text before any output, otherwise, nothing is output.

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `printfOutputSuffix` - Pipe to output some text after any output, otherwise, nothing

Pipe to output some text after any output, otherwise, nothing is output.

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Space trimming

### `trimWords` - Remove words from the end of a phrase

Remove words from the end of a phrase

- Location: `bin/build/tools/text.sh`

#### Arguments

- `wordCount` - Words to output
- `word0` - One or more words to output

#### Examples

    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `trimSpace` - Trim whitespace of a bash argument

Trim spaces and only spaces from arguments or a pipe

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to remove spaces

#### Examples

    trimSpace "$token"

#### Sample Output

    text
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Credits

Thanks to [Chris F.A. Johnson (2008)](https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816).
### `trimHead` - Removes any blank lines from the beginning of a stream

Removes any blank lines from the beginning of a stream

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `trimTail` - Removes any blank lines from the end of a stream

Removes any blank lines from the end of a stream

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `singleBlankLines` - Ensures blank lines are singular

Ensures blank lines are singular

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Finding or Calculating

### `inArray` - Check if an element exists in an array

Check if an element exists in an array

- Location: `bin/build/tools/text.sh`

#### Arguments

- `element` - Thing to search for
- `arrayElement0` - One or more array elements to match

#### Examples

    if inArray "$thing" "${things[@]}"; then things+=("$thing");
        things+=("$thing")
    fi

#### Exit codes

- `0` - If element is found in array
- `1` - If element is NOT found in array
### `isSubstring` - Check if one string is a substring of another set

Check if one string is a substring of another set of strings (case-sensitive)

- Location: `bin/build/tools/text.sh`

#### Arguments

- `needle` - Required. String. Thing to search for, not blank.
- `haystack ...` - Optional. EmptyString. One or more array elements to match

#### Exit codes

- `0` - If element is a substring of any haystack
- `1` - If element is NOT found as a substring of any haystack
### `isSubstringInsensitive` - Check if one string is a substring of another set

Check if one string is a substring of another set of strings (case-insensitive)

- Location: `bin/build/tools/text.sh`

#### Arguments

- `needle` - Required. String. Thing to search for, not blank.
- `haystack ...` - Optional. EmptyString. One or more array elements to match

#### Exit codes

- `0` - If element is a substring of any haystack
- `1` - If element is NOT found as a substring of any haystack
### `substringFound` - Find whether a substring exists in one or more strings

Does needle exist as a substring of haystack?

- Location: `bin/build/tools/text.sh`

#### Arguments

- `haystack` - Required. String. String to search.
- `needle` - Optional. String. One or more strings to find as a substring of `haystack`.

#### Exit codes

- `0` - IFF ANY needle matches as a substring of haystack
### `stringOffset` - Outputs the integer offset of `needle` if found as substring

Outputs the integer offset of `needle` if found as substring in `haystack`
If `haystack` is not found, -1 is output

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `maximumFieldLength` - Given an input file, determine the maximum length of fieldIndex,

Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields

Defaults to first field (fieldIndex of `1`), space separator (separatorChar is ` `)

- Location: `bin/build/tools/text.sh`

#### Arguments

- `fieldIndex` - The field to compute the maximum length for
- `separatorChar` - The separator character to delineate fields
- `fieldBasedFile` - A file with fields

#### Examples

    usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `maximumLineLength` - Outputs the maximum line length passed into stdin

Outputs the maximum line length passed into stdin

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Language-related

### `plural` - Outputs the `singular` value to standard out when the value

Outputs the `singular` value to standard out when the value of `number` is one.
Otherwise, outputs the `plural` value to standard out.


Example:

- Location: `bin/build/tools/text.sh`

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
### `parseBoolean` - Parses text and determines if it's true-ish

Parses text and determines if it's true-ish

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - true
- `1` - false
- `2` - Neither

## Transformation

### `lowercase` - Convert text to lowercase

Convert text to lowercase

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `uppercase` - Convert text to uppercase

Convert text to uppercase

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `shaPipe` - SHA1 checksum of standard input

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

- Location: `bin/build/tools/text.sh`

#### Arguments

- `filename` - One or more filenames to generate a checksum for

#### Examples

    shaPipe < "$fileName"
    shaPipe "$fileName0" "$fileName1"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

DEBUG_SHAPIPE - When set to a truthy value, will output all requested shaPipe calls to log called `shaPipe.log`.

#### Depends

    shasum
    
### `cachedShaPipe` - SHA1 checksum of standard input

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

Speeds up shaPipe using modification dates of the files instead.

The `cacheDirectory`

- Location: `bin/build/tools/text.sh`

#### Arguments

- `cacheDirectory` - Optional. Directory. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.

#### Examples

    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    shasum shaPipe
    
### `cannon` - Replace text `fromText` with `toText` in files, using `findArgs` to

Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.

This can break your files so use with caution. Blank searchText is not allowed.

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--path directory` - Optional. Directory. Run cannon operation starting in this directory.
- `fromText` - Required. String of text to search for.
- `toText` - Required. String of text to replace.
- `findArgs ...` - Optional. FindArgument. Any additional arguments are meant to filter files.

#### Examples

    cannon master main ! -path '*/old-version/*')

#### Exit codes

- `0` - Success
- `1` - --path is not a directory
- `1` - searchText is not blank
- `1` - mktemp failed
- `2` - Arguments are identical

#### See Also

{SEE:cannon.sh}
### `joinArguments` - Output arguments joined by a character

Output arguments joined by a character

- Location: `bin/build/tools/text.sh`

#### Arguments

- `separator` - Required. String. Single character to join elements.
- `text0` - Optional. String. One or more strings to join

#### Sample Output

    text
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `listAppend` - Add an item to the beginning or end of a

Add an item to the beginning or end of a text-delimited list

- Location: `bin/build/tools/text.sh`

#### Arguments

- `listValue` - Required. Path value to modify.
- `separator` - Required. Separator string for item values (typically `:`)
- `--first` - Optional. Place any items after this flag first in the list
- `--last` - Optional. Place any items after this flag last in the list. Default.
- `item` - the path to be added to the `listValue`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `listRemove` - Remove one or more items from a text-delimited list

Remove one or more items from a text-delimited list

- Location: `bin/build/tools/text.sh`

#### Arguments

- `listValue` - Required. List value to modify.
- `separator` - Required. Separator string for item values (typically `:`)
- `item` - the item to be removed from the `listValue`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `listCleanDuplicates` - Removes duplicates from a list and maintains ordering.

Removes duplicates from a list and maintains ordering.

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--help` - Optional. Flag. This help.
- `--removed` - Optional. Flag. Show removed items instead of the new list.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Characters

### `characterClassReport` - Write a report of the character classes

Write a report of the character classes

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--class` - Optional. Flag. Show class and then characters in that class.
- `--char` - Optional. Flag. Show characters and then class for that character.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `characterClasses` - List the valid character classes allowed in `isCharacterClass`

List the valid character classes allowed in `isCharacterClass`

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `characterFromInteger` - Given a list of integers, output the character codes associated

Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `characterToInteger` - Convert one or more characters from their ascii representation to

Convert one or more characters from their ascii representation to an integer value.
Requires a single character to be passed

- Location: `bin/build/tools/text.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isCharacterClasses` - Does this character match one or more character classes?

Does this character match one or more character classes?

- Location: `bin/build/tools/text.sh`

#### Arguments

- `character` - Required. Single character to test.
- `class0` - Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `stringValidate` - Ensure that every character in a text string passes all

Ensure that every character in a text string passes all character class tests

- Location: `bin/build/tools/text.sh`

#### Arguments

- `text` - Text to validate
- `class0` - One or more character classes that the characters in string should match

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `unquote` - Unquote a string

Unquote a string

- Location: `bin/build/tools/text.sh`

#### Arguments

- `quote` - String. Required. Must match beginning and end of string.
- `value` - String. Required. Value to unquote.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
