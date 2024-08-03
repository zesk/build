# Operating System Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Services


### `serviceToPort` - Get the port number associated with a service

Get the port number associated with a service

#### Usage

    serviceToPort service [ ... ]
    

#### Arguments



#### Sample Output

    Port number of associated service (integer) one per line
    

#### Exit codes

- `1` - service not found
- `2` - bad argument or invalid port
- `0` - service found and output is an integer

### `serviceToStandardPort` - Hard-coded services for:

Hard-coded services for:

- `ssh` -> 22
- `http`-> 80
- `https`-> 80
- `postgres`-> 5432
- `mariadb`-> 3306
- `mysql`-> 3306

Backup when `/etc/services` does not exist.

#### Usage

    serviceToStandardPort service [ ... ]
    

#### Arguments



#### Sample Output

    Port number of associated service (integer) one per line
    

#### Exit codes

- `1` - service not found
- `0` - service found and output is an integer

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

## Execution


### `whichExists` - IDENTICAL whichExists EOF

IDENTICAL whichExists EOF

#### Usage

    whichExists binary ...
    

#### Arguments



#### Exit codes

- `0` - If all values are found

### `runCount` - Run a binary count times

$\Run a binary count times

#### Usage

    runCount count binary [ args ... ]
    

#### Arguments



#### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned

### `chmod-sh.sh` - Makes all `*.sh` files executable

Makes all `*.sh` files executable

#### Usage

    chmod-sh.sh [ findArguments ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

Works from the current directory

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

## Modify PATH or MANPATH


#### Usage

    pathConfigure [ --first | --last | path ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    manPathConfigure [ --first | --last | path ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `pathCleanDuplicates` - Cleans the path and removes non-directory entries and duplicates

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

#### Usage

    pathCleanDuplicates
    

#### Exit codes

- `0` - Always succeeds

## Memory


### `processMemoryUsage` - Outputs value of resident memory used by a process, value

Outputs value of resident memory used by a process, value is in kilobytes

#### Usage

    processMemoryUsage pid
    

#### Arguments



#### Examples

    > processMemoryUsage 23

#### Sample Output

    423
    

#### Exit codes

- `0` - Success
- `2` - Argument error

### `processVirtualMemoryAllocation` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

#### Usage

    processVirtualMemoryAllocation pid
    

#### Arguments



#### Examples

    processVirtualMemoryAllocation 23

#### Sample Output

    423
    

#### Exit codes

- `0` - Success
- `2` - Argument error

## Miscellaneous


### `JSON` - Format something neatly as JSON

Format something neatly as JSON

#### Usage

    JSON < inputFile > outputFile
    

#### Exit codes

- `0` - Always succeeds
