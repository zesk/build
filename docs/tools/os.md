# Operating System Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Services

### `serviceToPort` - Get the port number associated with a service

Get the port number associated with a service

#### Arguments

- `service` - A unix service typically found in `/etc/services`
- `--services servicesFile` - Optional. File. File like '/etc/services`.

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

#### Arguments

- `service` - A unix service typically found in `/etc/services`

#### Sample Output

    Port number of associated service (integer) one per line
    

#### Exit codes

- `1` - service not found
- `0` - service found and output is an integer

## Execution

### `whichExists` - IDENTICAL whichExists EOF

IDENTICAL whichExists EOF

#### Arguments

- `binary` - Required. String. Binary to find in the system `PATH`.

#### Exit codes

- `0` - If all values are found
### `runCount` - Run a binary count times

$\Run a binary count times

#### Arguments

- `count` - The number of times to run the binary
- `binary` - The binary to run
- `args ...` - Any arguments to pass to the binary each run

#### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned
### `chmod-sh.sh` - Makes all `*.sh` files executable

Makes all `*.sh` files executable

#### Arguments

- `findArguments` - Optional. Add arguments to exclude files or paths.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Works from the current directory

## Modify PATH or MANPATH

#### Arguments

- `--first` - Optional. Place any paths after this flag first in the list
- `--last` - Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `PATH` environment

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `--first` - Optional. Place any paths after this flag first in the list
- `--last` - Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `MANPATH` environment

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `pathCleanDuplicates` - Cleans the path and removes non-directory entries and duplicates

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

#### Usage

    pathCleanDuplicates
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Memory

### `processMemoryUsage` - Outputs value of resident memory used by a process, value

Outputs value of resident memory used by a process, value is in kilobytes

#### Arguments

- `pid` - Process ID of running process

#### Examples

    > processMemoryUsage 23

#### Sample Output

    423
    

#### Exit codes

- `0` - Success
- `2` - Argument error
### `processVirtualMemoryAllocation` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

#### Arguments

- `pid` - Process ID of running process

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
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
