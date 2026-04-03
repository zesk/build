## `documentationMkdocs`

> Build documentation using mkdocs and a template

### Usage

    documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ]

Build documentation using mkdocs and a template

### Arguments

- `--path documentationPath` - Directory. Optional. Directory where documentation root exists.
- `--template yamlTemplate` - File. Optional. Name of mkdocs.yml template file to generate final file. Default is `mkdocs.template.yml`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

