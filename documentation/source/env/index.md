# Environment Variables

Note that you should place environment variables (if you override the default, for example), in:

    ./bin/env/VARIABLE_NAME.sh

Where `VARIABLE_NAME` is the name of your environment variable. `environmentAddFile` does this for you if you want.

These are the known environment variables in `Zesk Build` - to see the default behavior look at in `./bin/build/env`.

You can document your environment variables automatically using `Type:` and a description using comments and the
standard Zesk Build bash comment syntax of `# Name: value`

So an example environment file is:

    #!/usr/bin/env bash
    # Type: String
    # Category: Documentation
    # ID of CloudFront provider for web site, for invalidation
    export DOCUMENTATION_CLOUDFRONT_ID
    DOCUMENTATION_CLOUDFRONT_ID="${DOCUMENTATION_CLOUDFRONT_ID-}"

The values for `Type:` match [standard types](../guide/types.md). The `Category:` simply places it that documentation
category. The behavior here is to set the environment variable to blank unless it is set already. Most project
environment variables will follow this pattern unless they are derived from other environment variables and the idea is
that this value should come from, you know, the environment.

The exception to this is *derived values* (based on another environment variable, for example but can be specified) or
values which can be computed easily.

It's important to avoid logic in the environment loader file *unless* you are strict about access to the environment
variable solely through the [`buildEnvironmentLoad`](../tools/build.md#buildEnvironmentLoad) and [
`buildEnvironmentGet`](../tools/build.md#buildEnvironmentGet) calls as it is *NOT* a requirement to
accessing environment variables, rather a convenience.

As well, note that variables documented in this manner can generate their own documentation, and the type can be used to
validate environment variables.

Note that most environment variables will simply inherit the already-set value (as shown in the example above), except
in cases where it more of a project configuration such as `APPLICATION_NAME` or `APPLICATION_JSON`, for example.

Project configuration variables:

- `APPLICATION_NAME`, `APPLICATION_JSON`, `APPLICATION_JSON_PREFIX`, `BUILD_HOOK_EXTENSIONS`,
  `APPLICATION_CODE_EXTENSIONS`, `APPLICATION_CODE`

## See also

- [`buildEnvironmentLoad`](../tools/build.md#buildEnvironmentLoad)
- [`buildEnvironmentGet`](../tools/build.md#buildEnvironmentGet)

<!-- source/env/index.md is the original version of this file and the one which should be edited -->