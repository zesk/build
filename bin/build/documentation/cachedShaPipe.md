## `cachedShaPipe`

> SHA1 checksum of standard input

### Usage

    cachedShaPipe [ cacheDirectory ] [ filename ]

Use `textSHA --cache cacheDirectory` instead

### Arguments

- `cacheDirectory` - Directory. Optional. The directory where cache files can be stored exclusively for this function. Supports a blank value to disable caching, otherwise, it must be a valid directory.
- `filename` - File. Optional. File determine the sha value for.

### Reads standard input

any file

### Writes to standard output

`String`. A hexadecimal string which uniquely represents the data in `stdin`.

### Examples

    cachedShaPipe "$cacheDirectory" < "$fileName"
    cachedShaPipe "$cacheDirectory" "$fileName0" "$fileName1"

### Sample Output

cf7861b50054e8c680a9552917b43ec2b9edae2b

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

