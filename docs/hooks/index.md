# Hooks

[⬅ Return to documentation index](../index.md)

Hooks are scripts which are located in your project at:

    - `./bin/hooks/`

The hooks are executable scripts and have the name `hook-name.sh` where `hook-name` is how the hook is addressed and invoked.

Hooks are run via:

    runHook hook-name [ hookArguments ... ]
    runOptionalHook hook-name [ hookArguments ... ]

See [runHook](../tools/pipeline.sh.md) and [runOptionalHook](../tools/pipeline.sh.md) in the pipeline documentation.

And in some cases, a default hook is always available at `bin/build/hooks/`.

## Reference

- [Application Hooks](application.md)
- [Deployment Hooks](deployment.md)
- [Git Pre-Commit Hook](git-pre-commit.sh.md)
- [GitHub Release Hooks](github-release.md)
- [Test Hooks](test.md)
- [Version Hooks](version.md)

[⬅ Return to documentation index](../index.md)
