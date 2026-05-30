# {applicationName} Environment Variables

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

- [All environment variables](./all.md) &middot; [All functions](../tools/all.md)

**{applicationName}** supports environment variables and certain patterns around their usage to assist in documentation
and proper usage.

**None of these are a requirement** unless you use `buildEnvironmentLoad` or `buildEnvironmentGet` to access environment
variables or a tool which uses these functions.

The primary pattern is to place environment variables (if you override the default, for example), in:

    ./bin/env/VARIABLE_NAME.sh

Where `VARIABLE_NAME` is the name of your environment variable. `buildEnvironmentAdd` does this for you if you want.

Also `buildEnvironmentNames` shows all known names within the current application scope.

You can document your environment variables automatically using `Type:` and a description using comments and the
standard **{applicationName}** bash comment syntax of `# Name: value`

So an example environment file is:

    #!/usr/bin/env bash
    # Type: String
    # Category: Documentation
    # ID of CloudFront provider for web site, for invalidation
    export DOCUMENTATION_CLOUDFRONT_ID
    DOCUMENTATION_CLOUDFRONT_ID="${DOCUMENTATION_CLOUDFRONT_ID-}"

The values for `Type:` match [standard types](../guide/types.md). The `Category:` simply places the variable in that
documentation
category. The behavior here is to **set the environment variable to blank** unless it is set already. Most project
environment variables will follow this pattern unless they are derived from other environment variables and the idea is
that this value should come from, you know, the environment.

The exception to this is *derived values* (based on another environment variable) or values which can be computed
easily.

It's important to avoid side effects in the environment loader file *unless* you are strict about access to the
environment variable solely through the [`buildEnvironmentLoad`](../tools/build.md#buildEnvironmentLoad) and [
`buildEnvironmentGet`](../tools/build.md#buildEnvironmentGet) calls as it is *NOT* a requirement to accessing
environment variables, rather a convenience.

Environment variables documented using this scheme can generate their own documentation, and the `Type:` can be used to
validate environment variables by other tools.

Note that most environment variables will simply inherit the already-set value (as shown in the example above), except
in cases where it more of a project configuration such as `APPLICATION_NAME` or `APPLICATION_JSON` &mdash; which
tends to be a fixed value.

Project configuration variables:

- `APPLICATION_NAME`, `APPLICATION_JSON`, `APPLICATION_JSON_PREFIX`, `BUILD_HOOK_EXTENSIONS`,
  `APPLICATION_CODE_EXTENSIONS`, `APPLICATION_CODE`

See also:

- [`buildEnvironmentLoad`](../tools/build.md#buildenvironmentload)
- [`buildEnvironmentGet`](../tools/build.md#buildenvironmentget)

<!-- template/env-index.md is the original version of this file and the one which should be edited -->

{environmentCategoryList}

## Additional Details on Environment Variables

{environmentMore}

<!-- end of more stuff -->

See also:

- [All environment variables](./all.md)
- [All functions](../tools/all.md)

<!-- TEMPLATE footer 5 -->
<hr />

[⬅ Parent ](../index.md)


