### `documentationTemplateCompile`

> Document an item and generate a template (markdown). To custom

#### Usage

    documentationTemplateCompile template settingsFile

Document an item and generate a template (markdown). To custom format any
of the fields in this, write functions in the form `_documentationTemplateFormatter_${"name"}` such that
name matches the variable name (lower case alphanumeric characters and underscores).

Filter functions should modify the input/output pipe.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `template` - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`
- `settingsFile` - Required. Settings file to be loaded.

#### Return codes

- `0` - Success
- `1` - Template file not found

