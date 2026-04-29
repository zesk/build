## `validate "$handler" Fingerprint name "value"`

> Validates an application fingerprint

### Usage

    validate "$handler" Fingerprint name "value" value

Validates an application fingerprint
Example usage:
    case "$argument" in
    ...
    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "fingerprint" "deprecated") || return "$(convertValue $? 120 0)" ;;
    ...
    esac
    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose

### Arguments

- `value` - Key value to use. Required.

### Return codes

- `120` - Exit when fingerprint matches.

