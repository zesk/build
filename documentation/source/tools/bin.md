# Binaries

These are found in the `bin/build` directory and typically have equivalent functions within Zesk Build which are
similar.

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

These utilities can be accessed via the shell in the PATH:

    ./bin/build/

They are intended to be standalone tools useful for a variety of installation and package management functions:

- [`cannon.sh`](./text.md#cannon) - Same as [`cannon`](./text.md#cannon)
- [`chmod-sh.sh`](./platform.md#makeShellFilesExecutable) - Same as [
  `makeShellFilesExecutable`](./platform.md#makeShellFilesExecutable)
- [`identical-check.sh`](./identical.md#identicalCheck) - Same as [`identicalCheck`](./identical.md#identicalCheck)
- [`identical-repair.sh`](./identical.md#identicalCheckShell) - Same as [
  `identicalCheckShell`](./identical.md#identicalCheckShell) with some extra functionality.
- `install-bin-build.sh` - Install or upgrdades current version of Zesk Build in `./bin/build` if it is not installed
  already. Updates itself if required.
- [`map.sh`](./text.md#mapEnvironment) - Same as [`mapEnvironment`](./text.md#mapEnvironment)
- `need-bash.sh` - Tool to install `bash` in containers first which do not have it installed automatically (Alpine, for
  example)
- [`crontab-application-update.sh`](./crontab.md#crontabApplicationUpdate) - Same as [
  `crontabApplicationUpdate`](./crontab.md#crontabApplicationUpdate)

## Template scripts

- `test.sample.sh` - Template for your own `test.sh` to run Bash tests (or any test suites)
- `install.sample.sh` - Template to write your own `install-bin-build.sh` for your project.

## Development tools

- `bash-build.sh` - Tool to install `Zesk Build` in a new container, load it and modify the `.bashrc` to load it every
  time
- `bitbucket-container.sh` - Wrapper for `{SEE:bitbucketContainer}`
- `deprecated.sh` - Do a project-wide replacement of deprecated code with modern updates. May modify or break your code.
  example)
- [`local-container.sh`](./docker.md#dockerLocalContainer) - Same as [
  `dockerLocalContainer`](./docker.md#dockerLocalContainer)
- [`release-new.sh`](./version.md#releaseNew) - Same as [`releaseNew`](./version.md#releaseNew)
- [`release-notes.sh`](./git.md#releaseNotes) - Same as [`releaseNotes`](./git.md#releaseNotes)
- [`version-last.sh`](./git.md#gitVersionLast) - Same as [`gitVersionLast`](./git.md#gitVersionLast)
- [`version-list.sh`](./git.md/#gitVersionList) - Same as [`gitVersionList`](./git.md#gitVersionList)

## `tools.sh` to run commands

Do `source tools.sh` to load all functions into the current environment.

You can also do

    ./tools.sh decorate file "$(pwd)"

To run commands directly; note this is slower for larger scripts and can be used when a single function is necessary.

{__buildIdenticalRepair}

## `install-bin-build.sh`

{_installRemotePackage}

Modify the last line of this file when installing at a different project depth:

    __installPackageConfiguration ../.. "$@"

The `../..` is the relative path from the script to the project root directory. - {SEE:installInstallBuild} will do this
for you.
