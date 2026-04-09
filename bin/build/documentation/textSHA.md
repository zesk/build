## `textSHA`

> SHA1 checksum of standard input

### Usage

    textSHA [ filename ... ] [ --cache cacheDirectory ]

Generates a checksum of standard input and outputs a SHA1 checksum in hexadecimal without any extra stuff
You can use this as a pipe or pass in arguments which are files to be hashed.

### Arguments

- `filename ...` - File. One or more filenames to generate a checksum for
- `--cache cacheDirectory` - Directory. Cache file cache values here for speed optimization.

### Reads standard input

any file

### Writes to standard output

`String`. A hexadecimal string which uniquely represents the data in `stdin`.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `textSHA` - Outputs all requested textSHA calls to log called `textSHA.log`.

### Examples

    textSHA < "$fileName"
    textSHA "$fileName0" "$fileName1"

### Sample Output

cf7861b50054e8c680a9552917b43ec2b9edae2b

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

