# Services

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## Services File

Typically found at `/etc/services`.

The services file contains information regarding the known services available in the DARPA Internet. For each service a
single line should be present with the following information:

- `official service name`
- `port number`
- `protocol name`
- `aliases`

Items are separated by any number of blanks and/or tab characters. The `port number` and `protocol name` are considered
a single item; a `/` is used to separate the port and protocol (e.g. `512/tcp`). A `#` indicates the
beginning of a comment; subsequent characters up to the end of the line are not interpreted by the routines which search
the file.

Service names may contain any printable character other than a field delimiter, newline, or comment character.

{serviceToPort}

{serviceToStandardPort}
