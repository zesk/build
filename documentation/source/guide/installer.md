# Build your own installer

A utility/internal function called [`_installRemotePackage`](../tools/build.md#_installRemotePackage) allows for
building of your own installer for a software package. It inherits all of the capabilities of `install-bin-build.sh`:

1. Optional version check
2. Optional url generator (to check remote package to get the current version first)
3. Automatic update of installation binary in-place in project
4. Optional post-installation validation and notices
5. Local installation for testing and mocking

Installation is a download of a `tar.gz` file and then expansion into the application root.

When you write an installer, be sure to run `bashCheckRequries` as part of your testing process:

    bashCheckRequires --ignore-prefix __decorateExtension --require --unused --report "$home/bin/my-installer.sh" || return $?

This ensures that all dependent functions are included in the installation file (as this is necessary to allow copying of the installer script to another project).

TODO continue and finish this.
