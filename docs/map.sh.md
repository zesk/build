# `map.sh` - Description

Map tokens in the input stream based on environment values with the same names.

Converts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.

Undefined values are not converted.

## Usage

    map.sh [ environmentName0 environmentName1 ... ]

## Arguments

- `environmentName0` - Map this value only

## Exit codes

Zero.

## Local cache

No local caches.

## Environment

Argument-passed or entire environment variables which are exported are used and mapped to the destination.

## Examples

    echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world map.sh NAME PLACE

[⬅ Return to top](index.md)
