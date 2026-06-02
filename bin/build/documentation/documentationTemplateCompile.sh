#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-02
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
line="436"
rawComment=$'Document an item and generate a template (markdown). To custom format any\nof the fields in this, write functions in the form `_documentationTemplateFormatter_${name}` such that\nname matches the variable name (lower case alphanumeric characters and underscores).\nFilter functions should modify the input/output pipe; an example can be found by looking at\nsample function `_documentationTemplateFormatter_return_code`.\nSee: _documentationTemplateFormatter_return_code\nArgument: template - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`\nArgument: settingsFile - Required. Settings file to be loaded.\nReturn Code: 0 - Success\nReturn Code: 1 - Template file not found\nShort description: Simple markdown documentation templates\n\n'
return_code=$'0 - Success\n1 - Template file not found\n'
see=$'_documentationTemplateFormatter_return_code\n'
short_description=$'Simple markdown documentation templates\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="13134038a36d80d9eea8bb3ddf5535edac40ac2b"
sourceLine="436"
summary="Document an item and generate a template (markdown). To custom"
summaryComputed="true"
usage="documentationTemplateCompile template settingsFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationTemplateCompile'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtemplate'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msettingsFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtemplate      '$'\e''[[(value)]mRequired. A markdown template to use to map values. Post-processed with '$'\e''[[(code)]mmarkdownRemoveUnfinishedSections'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msettingsFile  '$'\e''[[(value)]mRequired. Settings file to be loaded.'$'\e''[[(reset)]m'$'\n'''$'\n''Document an item and generate a template (markdown). To custom format any'$'\n''of the fields in this, write functions in the form '$'\e''[[(code)]m_documentationTemplateFormatter_$#24/26 - documentationTemplateCompile'$'\e''[[(reset)]m such that'$'\n''name matches the variable name (lower case alphanumeric characters and underscores).'$'\n'''$'\n''Filter functions should modify the input/output pipe; an example can be found by looking at'$'\n''sample function '$'\e''[[(code)]m_documentationTemplateFormatter_return_code'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Template file not found'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateCompile template settingsFile'$'\n'''$'\n''    template      Required. A markdown template to use to map values. Post-processed with markdownRemoveUnfinishedSections'$'\n''    settingsFile  Required. Settings file to be loaded.'$'\n'''$'\n''Document an item and generate a template (markdown). To custom format any'$'\n''of the fields in this, write functions in the form _documentationTemplateFormatter_$#24/26 - documentationTemplateCompile such that'$'\n''name matches the variable name (lower case alphanumeric characters and underscores).'$'\n'''$'\n''Filter functions should modify the input/output pipe; an example can be found by looking at'$'\n''sample function _documentationTemplateFormatter_return_code.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Template file not found'
documentationPath="documentation/source/tools/documentation.md"
