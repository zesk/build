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



ExitCode _bashDocumentation_Template listTokens  ./docs/_templates/__function.md: 1

ExitCode _bashDocumentation_Template mapValue  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template mapValueTrim  ./docs/_templates/__function.md: 1

### Space trimming

ExitCode _bashDocumentation_Template trimWords  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template trimSpace  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template trimSpacePipe  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template trimHead  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template trimTail  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template singleBlankLines  ./docs/_templates/__function.md: 1

## Finding or Calculating

ExitCode _bashDocumentation_Template stringOffset  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template maximumFieldLength  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template maximumLineLength  ./docs/_templates/__function.md: 1

## Language-related

ExitCode _bashDocumentation_Template plural  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template parseBoolean  ./docs/_templates/__function.md: 1

## Transformation

ExitCode _bashDocumentation_Template lowercase  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template uppercase  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template shaPipe  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template cachedShaPipe  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template cannon  ./docs/_templates/__function.md: 1

# Characters

ExitCode _bashDocumentation_Template characterClassReport  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template characterClasses  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template characterFromInteger  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template characterToInteger  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template isCharacterClasses  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template stringValidate  ./docs/_templates/__function.md: 1


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
