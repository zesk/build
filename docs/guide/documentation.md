# Documentation

Zesk Build has some documentation tools which can be used in any project to document your Bash code simply.

To add automatic usage for a function, the pattern to use is:

    # Lay an egg
    layAnEgg() {
        ...
        if [ -z "$hay" ]; then
          _layAnEgg 1 "No hay" || return $?
        fi 
        ...
    }
    _layAnEgg() {
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

The default display is:

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

Additional sections will be added, and the above documentation can be converted into Markdown documentation.
