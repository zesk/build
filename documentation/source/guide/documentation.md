# Documentation

Zesk Build has some documentation tools which can be used in any project to document your `bash` code simply.

To add automatic usage for a function, the pattern to use is to add a comment before the function as shown here and add
a usage handler which is your function name prefixed with a single underscore (`_`):

    # Lay an egg
    layAnEgg() {
        local usage="_${FUNCNAME[0]}"
        ...
        [ -n "$hay" ] || __throwEnvironment "$usage" "No hay" || return $?
        ...
    }
    _layAnEgg() {
      # __IDENTICAL__ usageDocument 1 
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

To add `--help` support for simple functions, use the `__help` function:

    [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0

The above will add `myFunction --help` support for simple functions as well as error handling. In the above example,
when the

    No hay
    
    Usage: layAnEgg
    
    Lay an egg

You can add arguments, exit codes, summary lines, or even rename the function to something else in the documentation:

    # fn: makeCryptoThing
    # Lay an egg. You can use `markdown` in *here*. **Cool**.
    # Argument: name - Required. String. What to name the egg.
    # Argument: --debug - Optional. Flag. Turn on debugging.`
    # Exit Code: 0 - Success
    # Exit Code: 1 - Environment error
    # Exit Code: 2 - Argument error
    # Example: {fn} newEgg 
    # Output: Eggs laid: 2000
    layAnEgg() {
        ...
    }

Will generate:

    All is great
    
    Usage: makeCryptoThing name [ --debug ]
    
        name     Required. String. What to name the egg.
        --debug  Optional. Flag. Turn on debugging.`
    
    Lay an egg.
    
    You can use markdown in here. Cool.
    
    The end.

Additional sections will be added, and the above documentation can also be converted into Markdown documentation.

Valid argument types are:
