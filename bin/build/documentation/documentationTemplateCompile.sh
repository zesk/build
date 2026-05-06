#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="template - Required. A markdown template to use to map values. Post-processed with \`markdownRemoveUnfinishedSections\`"$'\n'"settingsFile - Required. Settings file to be loaded."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Document an item and generate a template (markdown). To custom format any"$'\n'"of the fields in this, write functions in the form \`_documentationTemplateFormatter_\${name}\` such that"$'\n'"name matches the variable name (lower case alphanumeric characters and underscores)."$'\n'""$'\n'"Filter functions should modify the input/output pipe; an example can be found by looking at"$'\n'"sample function \`_documentationTemplateFormatter_return_code\`."$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/documentation.sh"
fn="documentationTemplateCompile"
fnMarker="documentationtemplatecompile"
foundNames=([0]="see" [1]="argument" [2]="return_code" [3]="short_description")
line="426"
rawComment="Document an item and generate a template (markdown). To custom format any"$'\n'"of the fields in this, write functions in the form \`_documentationTemplateFormatter_\${name}\` such that"$'\n'"name matches the variable name (lower case alphanumeric characters and underscores)."$'\n'"Filter functions should modify the input/output pipe; an example can be found by looking at"$'\n'"sample function \`_documentationTemplateFormatter_return_code\`."$'\n'"See: _documentationTemplateFormatter_return_code"$'\n'"Argument: template - Required. A markdown template to use to map values. Post-processed with \`markdownRemoveUnfinishedSections\`"$'\n'"Argument: settingsFile - Required. Settings file to be loaded."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Template file not found"$'\n'"Short description: Simple markdown documentation templates"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Template file not found"$'\n'""
see="_documentationTemplateFormatter_return_code"$'\n'""
short_description="Simple markdown documentation templates"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="426"
summary="Document an item and generate a template (markdown). To custom"
summaryComputed="true"
usage="documentationTemplateCompile template settingsFile"
