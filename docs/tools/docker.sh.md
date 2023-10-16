# Docker Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `insideDocker` - Are we inside the matrix or not?

Determine if we are currently within a docker container. The jury is out as to whether this is a good idea and also whether this even works.

### Usage

    insideDocker

### Arguments

None

### Environment

Checks the local environment to determine if we are inside a docker container. Looks at `/proc/1/sched` for a process not named `init` and if so, we are inside `docker`.

### Exit codes

- 0 - inside docker container
- 1 - not inside docker container

## `dumpDockerTestFile` - Dump the docker file used to see if we're in Docker

Given that it's not clear if `insideDocker` works, this dumps the `/proc/1/sched` file to debug the efficacy of the above.


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)