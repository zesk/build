#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'template - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`\nsettingsFile - Required. Settings file to be loaded.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Document an item and generate a template (markdown). To custom format any\nof the fields in this, write functions in the form `_documentationTemplateFormatter_${name}` such that\nname matches the variable name (lower case alphanumeric characters and underscores).\n\nFilter functions should modify the input/output pipe; an example can be found by looking at\nsample function `_documentationTemplateFormatter_return_code`.\n\n'
descriptionLineCount="7"
file="bin/build/tools/documentation.sh"
fn="documentationTemplateCompile"
fnMarker="documentationtemplatecompile"
foundNames=([0]="see" [1]="argument" [2]="return_code" [3]="short_description")
line="426"
rawComment=$'Document an item and generate a template (markdown). To custom format any\nof the fields in this, write functions in the form `_documentationTemplateFormatter_${name}` such that\nname matches the variable name (lower case alphanumeric characters and underscores).\nFilter functions should modify the input/output pipe; an example can be found by looking at\nsample function `_documentationTemplateFormatter_return_code`.\nSee: _documentationTemplateFormatter_return_code\nArgument: template - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`\nArgument: settingsFile - Required. Settings file to be loaded.\nReturn Code: 0 - Success\nReturn Code: 1 - Template file not found\nShort description: Simple markdown documentation templates\n\n'
return_code=$'0 - Success\n1 - Template file not found\n'
see=$'_documentationTemplateFormatter_return_code\n'
short_description=$'Simple markdown documentation templates\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="426"
summary="Document an item and generate a template (markdown). To custom"
summaryComputed="true"
usage="documentationTemplateCompile template settingsFile"
