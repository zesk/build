## `buildDocumentationBuild`

> Build the build documentation

### Usage

    buildDocumentationBuild [ --none ] [ --templates-only ] [ --templates ] [ --no-templates ] [ --derived ] [ --no-derived ] [ --derived-only ] [ --reference ] [ --no-reference ] [ --reference-only ] [ --mkdocs ] [ --no-mkdocs ] [ --mkdocs-only ] [ --see-update ] [ --index-update ] [ --docs-update ] [ --env-update ] [ --clean ] [ --verbose ] [ --filter filters ... ] [ --force ] [ --debug ]

Build the build documentation

### Arguments

- `--none` - Flag. Turn off all updates.
- `--templates-only` - Flag. Just template identical updates.
- `--templates` - Flag. Enable template updates.
- `--no-templates` - Flag. Disable template updates.
- `--derived` - Flag. Enable derived files updates.
- `--no-derived` - Flag. Disable derived files updates.
- `--derived-only` - Flag. Just derived files only.
- `--reference` - Flag. Enable reference file updates.
- `--no-reference` - Flag. Disable reference file updates.
- `--reference-only` - Flag. Reference file updates.
- `--mkdocs` - Flag. Enable documentation generation.
- `--no-mkdocs` - Flag. Disable documentation generation.
- `--mkdocs-only` - Flag. Documentation generation only.
- `--see-update` - Flag. Documentation generation only.
- `--index-update` - Flag. Documentation generation only.
- `--docs-update` - Flag. Documentation generation only.
- `--env-update` - Flag. Just update env document.
- `--clean` - Flag. Clean caches.
- `--verbose` - Flag. Clean caches.
- `--filter filters ...` - DashDashDelimitedArguments. Arguments to filter which reference files are updated.
- `--force` - Flag. Force building of everything.
- `--debug` - Flag. Debugging output enabled.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

