# Build your own installer

A utility/internal function called [`_installRemotePackage`](../tools/build.md#_installRemotePackage) allows for
building of your own installer for a software package. It inherits all of the capabilities of `install-bin-build.sh`:

1. Optional version check
1. Optional url generator (to check remote package to get the current version first)
1. Automatic update of installation binary in-place in project
1. Optional post-installation validation and notices
1. Local installation for testing and mocking

Installation is a download of a `tar.gz` file and then expansion into the application root. 
