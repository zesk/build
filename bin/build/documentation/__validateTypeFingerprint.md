### `validate "$handler" Fingerprint name "fingerprintSpec"`

> Validates an application fingerprint

#### Usage

    validate "$handler" Fingerprint name "fingerprintSpec" [ name ] fingerprintSpec

Validates an application fingerprint
Default hook is `application-fingerprint`.
Example usage:

    case "$argument" in
    ...
    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;
    ...
    esac

    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose

This function returns the exit return code when fingerprint matches; the calling function should return immediately with a successful exit code.

> Location: `bin/build/tools/fingerprint.sh`

#### Arguments

- `name` - Use `-` for the default hook, or pass in a hook name to use to calculate the fingerprint.
- `fingerprintSpec` - String. Required. The value used is the stored fingerprint path in the application JSON file. Specify `hookName:jsonPath` to specify a custom hook name for the value.

#### Return codes

- `120` - Calling function should exit

