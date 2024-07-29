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

#### Usage

    isCharacterClass className character0 [ character1 ... ]
    

#### Exit codes

- `0` - Always succeeds

## Filters


#### Exit codes

- `0` - Always succeeds

### `quoteSedPattern` - Quote sed strings for shell use

Quote a string to be used in a sed pattern on the command line.

#### Usage

    quoteSedPattern text
    

#### Arguments



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



#### Examples

    name="$(quoteBashString "$name")"

#### Sample Output

    string quoted and appropriate to assign to a value in the shell
    

#### Exit codes

- `0` - Always succeeds

#### Depends

    sed
    

### `quoteGrepPattern` - Quote grep -e patterns for shell use

$\Quote grep -e patterns for shell use

#### Usage

    quoteGrepPattern text
    

#### Arguments



#### Examples

    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"

#### Sample Output

    string quoted and appropriate to insert in a grep search or replacement phrase
    

#### Exit codes

- `0` - Always succeeds


### `escapeQuotes` - Quote strings for inclusion in shell quoted strings

Quote strings for inclusion in shell quoted strings

#### Usage

    escapeSingleQuotes text
    

#### Arguments



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



#### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

#### Sample Output

    Single quotes are prefixed with a backslash
    

#### Exit codes

- `0` - Always succeeds

### `escapeBash` - Converts strings to shell escaped strings

Converts strings to shell escaped strings

#### Usage

    escapeBash [ text }
    

#### Exit codes

- `0` - Always succeeds

### `replaceFirstPattern` - Replaces the first and only the first occurrence of a

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.

#### Usage

    replaceFirstPattern pattern replacement
    

#### Exit codes

- `0` - Always succeeds

### `removeFields` - Remove fields from left to right from a text file

Remove fields from left to right from a text file as a pipe

#### Usage

    removeFields fieldCount < input > output
    

#### Arguments



#### Exit codes

- `0` - Always succeeds


### `stripAnsi` - Strip ANSI console escape sequences from a file

Strip ANSI console escape sequences from a file

#### Usage

    stripAnsi < input > output
    

#### Arguments



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



#### Exit codes

- `0` - Always succeeds

### `mapValueTrim` - Maps a string using an environment file

Maps a string using an environment file

#### Usage

    mapValueTrim mapFile [ value ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### Space trimming


### `trimWords` - Remove words from the end of a phrase

Remove words from the end of a phrase

#### Usage

    trimWords [ wordCount [ word0 ... ] ]
    

#### Arguments



#### Examples

    printf "%s: %s\n" "Summary:" "$(trimWords 10 $description)"

#### Exit codes

- `0` - Always succeeds

### `trimSpace` - Trim whitespace of a bash argument

Trim spaces and only spaces from arguments or a pipe

#### Usage

    trimSpace text
    

#### Arguments



#### Examples

    trimSpace "$token"

#### Sample Output

    text
    

#### Exit codes

- `0` - Always succeeds

#### Credits

Thanks to [Chris F.A. Johnson (2008)](https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816).

### `trimHead` - Removes any blank lines from the beginning of a stream

Removes any blank lines from the beginning of a stream

#### Usage

    trimHead
    

#### Exit codes

- `0` - Always succeeds

### `trimTail` - Removes any blank lines from the end of a stream

Removes any blank lines from the end of a stream

#### Usage

    trimTail
    

#### Exit codes

- `0` - Always succeeds

### `singleBlankLines` - Ensures blank lines are singular

Ensures blank lines are singular

#### Usage

    singleBlankLines
    

#### Exit codes

- `0` - Always succeeds

## Finding or Calculating


### `inArray` - Check if an element exists in an array

Check if an element exists in an array

#### Usage

    inArray element [ arrayElement0 arrayElement1 ... ]
    

#### Arguments



#### Exit codes

- `0` - If element is found in array
- `1` - If element is NOT found in array

### `isSubstring` - Check if one string is a substring of another set

Check if one string is a substring of another set of strings (case-sensitive)

#### Usage

    isSubstring needle [ haystack ... ]
    

#### Arguments



#### Exit codes

- `0` - If element is a substring of any haystack
- `1` - If element is NOT found as a substring of any haystack

### `isSubstringInsensitive` - Check if one string is a substring of another set

Check if one string is a substring of another set of strings (case-insensitive)

#### Usage

    isSubstringInsensitive needle [ haystack ... ]
    

#### Arguments



#### Exit codes

- `0` - If element is a substring of any haystack
- `1` - If element is NOT found as a substring of any haystack

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



#### Examples

    usageOptions | usageGenerator $(usageOptions | maximumFieldLength 1 ;) ;

#### Exit codes

- `0` - Always succeeds

### `maximumLineLength` - Outputs the maximum line length passed into stdin

Outputs the maximum line length passed into stdin

#### Usage

    maximumLineLength
    

#### Exit codes

- `0` - Always succeeds

## Language-related


### `plural` - Outputs the `singular` value to standard out when the value

Outputs the `singular` value to standard out when the value of `number` is one. Otherwise outputs the `plural` value to standard out.


Example:

#### Usage

    plural number singular plural
    

#### Arguments



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

#### Usage

    parseBoolean text
    

#### Exit codes

- `0` - true
- `1` - false
- `2` - Neither

#### See Also

{SEE:lowercase}

## Transformation


### `lowercase` - Convert text to lowercase

Convert text to lowercase

#### Usage

    lowercase [ text ... ]
    

#### Exit codes

- `0` - Always succeeds

### `uppercase` - Convert text to uppercase

Convert text to uppercase

#### Usage

    uppercase [ text ... ]
    

#### Exit codes

- `0` - Always succeeds

### `shaPipe` - SHA1 checksum of standard input

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff

You can use this as a pipe or pass in arguments which are files to be hashed.

#### Usage

    shaPipe [ filename ... ]
    

#### Arguments



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

The `cacheDirectory`

#### Usage

    cachedShaPipe cacheDirectory [ filename ]
    

#### Arguments



#### Examples

    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Always succeeds

#### Depends

    shasum shaPipe
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    joinArguments separator text0 arg1 ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

# Characters


### `characterClassReport` - Write a report of the character classes

Write a report of the character classes

#### Usage

    characterClassReport
    

#### Exit codes

- `0` - Always succeeds

#### Exit codes

- `0` - Always succeeds

### `characterFromInteger` - Given a list of integers, output the character codes associated

Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)

#### Exit codes

- `0` - Always succeeds

### `characterToInteger` - Convert one or more characters from their ascii representation to

Convert one or more characters from their ascii representation to an integer value.
Requires a single character to be passed

#### Usage

    characterToInteger [ character ... ]
    

#### Exit codes

- `0` - Always succeeds

### `isCharacterClasses` - Does this character match one or more character classes?

Does this character match one or more character classes?

#### Usage

    isCharacterClasses character [ class0 class1 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    stringValidate text class0 [ ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

<!-- TEMPLATE footer 5 -->
<hr />

[⬅ Top](index.md) [⬅ Parent ](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=Text Functions)
