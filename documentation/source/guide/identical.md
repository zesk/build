# Identical Tools

Early on in this toolkit development it became clear that Bash as a language was lacking a few features - largely the
ability to ensure and guarantee that code snippets across functions remain identical - basically no easy way to generate
code templates which are re-used throughout the code. 

So as a solution the `identicalCheck` and `identicalRepair` tools were added which scans code for specific patterns and ensures everything is kept in sync.

You may define *any* line and count-based token to delimit your code and define as many tokens as needed. Internally, Zesk Build uses:

    # IDENTICAL tokenName 1
    # _IDENTICAL_ tokenName 1
    # __IDENTICAL__ tokenName 1
    # DOC TEMPLATE: tokenName 1

The `IDENTICAL` ones are used for `bash` code while the `DOC TEMPLATE:` pattern is used for comment/arguments which are identical across functions. 

You may re-use these tokens in your own code or create your own.

## Identical Features

### Singles Reporting

The point of the identical matching is to ensure that code matches in two places; after a scan the identical matching will list tokens which have a single instance only - while it may not be an error, it may prove useful to remove 
