# `BASH_SOURCE` and `FUNCNAME`

`$BASH_SOURCE` only has multiple entries if function calls are involved, in which case its elements parallel the `FUNCNAME` array that contains all function names currently on the call stack.

That is, inside a function, `${FUNCNAME[0]}` contains the name of the executing function, and `${BASH_SOURCE[0]}` contains the path of the script file in which that function is defined, ${FUNCNAME[1]} contains the name of the function from which the currently executing function was called, if applicable, and so on.

If a given function was invoked directly from the top-level scope in the script file that defined the function at level $i of the call stack, `${FUNCNAME[$i+1]}` contains:

main (a pseudo function name), if the script file was invoked directly (e.g., ./script)

source (a pseudo function name), if the script file was sourced (e.g. source ./script or . ./script).

> Source: [StackOverflow](https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source)
> 
