# Assert Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals expected actual [ message ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - Expected string
[48;5;16;38;5;11m- `actual` - Actual string
[48;5;16;38;5;11m- `message` - Message to output if the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal. If this fails it will 
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals expected actual [ message ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - Expected string
[48;5;16;38;5;11m- `actual` - Actual string
[48;5;16;38;5;11m- `message` - Message to output if the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertNotEquals expected actual [ message ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - Expected string
[48;5;16;38;5;11m- `actual` - Actual string
[48;5;16;38;5;11m- `message` - Message to output if the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNo local caches.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11m    assertNotEquals "$(head -1 /proc/1/sched | awk '{ print $1 })" "init" "sched should not be init"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mAssert two strings are not equal.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertNotEquals
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal. If this fails it will 
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals expected actual [ message ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - Expected string
[48;5;16;38;5;11m- `actual` - Actual string
[48;5;16;38;5;11m- `message` - Message to output if the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertNotEquals expected actual [ message ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - Expected string
[48;5;16;38;5;11m- `actual` - Actual string
[48;5;16;38;5;11m- `message` - Message to output if the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNo local caches.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11m    assertNotEquals "$(head -1 /proc/1/sched | awk '{ print $1 })" "init" "sched should not be init"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertExitCode expectedExitCode command [ arguments ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expectedExitCode` - A numeric exit code expected from the command
[48;5;16;38;5;11m- `command` - The command to run
[48;5;16;38;5;11m- `arguments` - Any arguments to pass to the command to run
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexamples=$(cat <<'EOF'
[48;5;16;38;5;11massertExitCode 0 hasHook version-current
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mAssert two strings are not equal.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mAssert a process runs and exits with the correct exit code.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertExitCode
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mAssert two strings are equal. If this fails it will 
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertNotExitCode expectedExitCode command [ arguments ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expectedExitCode` - A numeric exit code not expected from the command
[48;5;16;38;5;11m- `command` - The command to run
[48;5;16;38;5;11m- `arguments` - Any arguments to pass to the command to run
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexamples=$(cat <<'EOF'
[48;5;16;38;5;11massertNotExitCode 0 hasHook make-cash-quickly
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11mAssert a process runs and exits with an exit code which does not match the passed in exit code.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output an error and exit.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertNotExitCode
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mAssert a process runs and exits with an exit code 
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertOutputContains expected command [ arguments ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `expected` - A string to expect in the output
[48;5;16;38;5;11m- `command` - The command to run
[48;5;16;38;5;11m- `arguments` - Any arguments to pass to the command to run
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m0 - If the output contains at least one occurrence of the string
[48;5;16;38;5;11m1 - If output does not contain string
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertOutputContains Success complex-thing.sh --dry-run
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11mRun a command and expect the output to contain the occurrence of a string.
[48;5;16;38;5;11m
[48;5;16;38;5;11mIf this fails it will output the command result to stdout.
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertOutputContains
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mRun a command and expect the output to contain the 
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mNo environment dependencies or modifications.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertDirectoryExists directory [ message ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `directory` - Directory that should exist
[48;5;16;38;5;11m- `message` - An error message if this fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m- `0` - If the assertion succeeds
[48;5;16;38;5;11m- `1` - If the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11m- This fails if `directory` is anything but a `directory`
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11m    assertDirectoryExists "$HOME" "HOME not found"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mTest that a directory exists
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertDirectoryExists
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11mNever
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertDirectoryDoesNotExist directory [ message ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `directory` - Directory that should NOT exist
[48;5;16;38;5;11m- `message` - An error message if this fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m- `0` - If the assertion succeeds
[48;5;16;38;5;11m- `1` - If the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11m- This fails if `directory` is anything at all, even a non-directory (such as a link)
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexamples=$(cat <<'EOF'
[48;5;16;38;5;11m    assertDirectoryDoesNotExists "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11mTest that a directory does not exist
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertDirectoryDoesNotExist
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertFileContains fileName string0 [ ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `fileName` - File to search
[48;5;16;38;5;11m- `string0 ...` - One or more strings which must be found on at least one line in the file
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m- `0` - If the assertion succeeds
[48;5;16;38;5;11m- `1` - If the assertion fails
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mIf the file does not exist, this will fail.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertFileContains $logFile Success
[48;5;16;38;5;11m    assertFileContains $logFile "is up to date"
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11m2023-10-12
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertFileContains
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[1;31mFailed[0m
[48;5;16;38;5;11m#!/usr/bin/env bash
[48;5;16;38;5;11mset -eou pipefail
[48;5;16;38;5;11musage=$(cat <<'EOF'
[48;5;16;38;5;11massertFileDoesNotContain fileName string0 [ ... ]
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11margument=$(cat <<'EOF'
[48;5;16;38;5;11m- `fileName` - File to search
[48;5;16;38;5;11m- `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexit_code=$(cat <<'EOF'
[48;5;16;38;5;11m- `1` - If the assertions fails
[48;5;16;38;5;11m- `0` - If the assertion succeeds
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mlocal_cache=$(cat <<'EOF'
[48;5;16;38;5;11mNone
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11menvironment=$(cat <<'EOF'
[48;5;16;38;5;11mIf the file does not exist, this will fail.
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mexample=$(cat <<'EOF'
[48;5;16;38;5;11massertFileDoesNotContain $logFile error Error ERROR
[48;5;16;38;5;11massertFileDoesNotContain $logFile warning Warning WARNING
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mdescription=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfn=$(cat <<'EOF'
[48;5;16;38;5;11massertFileDoesNotContain
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mfile=$(cat <<'EOF'
[48;5;16;38;5;11m./bin/build/tools/assert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mbase=$(cat <<'EOF'
[48;5;16;38;5;11massert.sh
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mshort_description=$(cat <<'EOF'
[48;5;16;38;5;11m
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)
[48;5;16;38;5;11mreviewed=$(cat <<'EOF'
[48;5;16;38;5;11mNever
[48;5;16;38;5;11mEOF
[48;5;16;38;5;11m)

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
