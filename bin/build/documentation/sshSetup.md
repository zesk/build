### `sshSetup`

> Set up SSH for a user with ID and backup

#### Usage

    sshSetup [ --force ] server

Set up SSH for a user with ID and backup keys in `~/.ssh`

Create a key for a user for SSH authentication to other servers.

Add .ssh key for current user

You will need the password for this server for the current user.



> Location: `bin/build/tools/ssh.sh`

#### Arguments

- `--force` - Flag. Optional. Force the program to create a new key if one exists
- `server` - String. Required. Servers to connect to to set up authorization

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires



#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/ssh.sh`, function `sshSetup` was reviewed {reviewed}.

#### Errors

{error}
