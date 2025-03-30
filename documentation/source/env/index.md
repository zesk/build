# Environment Variables

Note that you should place environment variables, if you override the default for example, in:

    ./bin/env/VARIABLE_NAME.sh

Where `VARIABLE_NAME` is the name of your environment variable.

These are the known environment variables in `Zesk Build` - to see the default behavior look at in `./bin/build/env`.

You can document your environment variables automatically using `Type:` and a description using comments and the standard Zesk Build bash comment syntax of `# Name: value`

So an example environment file is:

    #!/usr/bin/env bash
    # Type: String
    # ID of CloudFront provider for web site, for invalidation
    export DOCUMENTATION_CLOUDFRONT_ID
    DOCUMENTATION_CLOUDFRONT_ID="${DOCUMENTATION_CLOUDFRONT_ID-}"

The values for `Type:` match any function named `usageArgumenType`.

See also [buildEnvironmentLoad](../tools/environment.md#buildEnvironmentLoad) and [buildEnvironmentGet](../tools/environment.md#buildEnvironmentGet).
