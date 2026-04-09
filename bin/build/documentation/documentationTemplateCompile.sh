#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="template - Required. A markdown template to use to map values. Post-processed with \`markdownRemoveUnfinishedSections\`"$'\n'"settingsFile - Required. Settings file to be loaded."$'\n'""
base="documentation.sh"
description="Document a function and generate a function template (markdown). To custom format any"$'\n'"of the fields in this, write functions in the form \`_documentationTemplateFormatter_\${name}\` such that"$'\n'"name matches the variable name (stringLowercase alphanumeric characters and underscores)."$'\n'"Filter functions should modify the input/output pipe; an example can be found in \`{file}\` by looking at"$'\n'"sample function \`_documentationTemplateFormatter_return_code\`."$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateCompile"
foundNames=([0]="see" [1]="argument" [2]="return_code" [3]="short_description")
line="439"
lowerFn="documentationtemplatecompile"
rawComment="Document a function and generate a function template (markdown). To custom format any"$'\n'"of the fields in this, write functions in the form \`_documentationTemplateFormatter_\${name}\` such that"$'\n'"name matches the variable name (stringLowercase alphanumeric characters and underscores)."$'\n'"Filter functions should modify the input/output pipe; an example can be found in \`{file}\` by looking at"$'\n'"sample function \`_documentationTemplateFormatter_return_code\`."$'\n'"See: _documentationTemplateFormatter_return_code"$'\n'"Argument: template - Required. A markdown template to use to map values. Post-processed with \`markdownRemoveUnfinishedSections\`"$'\n'"Argument: settingsFile - Required. Settings file to be loaded."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Template file not found"$'\n'"Short description: Simple bash function documentation"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Template file not found"$'\n'""
see="_documentationTemplateFormatter_return_code"$'\n'""
short_description="Simple bash function documentation"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="d079b892a371cbbf3a4c8696e9e186c0c6c2e830"
sourceLine="439"
summary="Document a function and generate a function template (markdown). To"
summaryComputed="true"
usage="documentationTemplateCompile template settingsFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationTemplateCompile'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtemplate'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msettingsFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtemplate      '$'\e''[[(value)]mRequired. A markdown template to use to map values. Post-processed with '$'\e''[[(code)]mmarkdownRemoveUnfinishedSections'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msettingsFile  '$'\e''[[(value)]mRequired. Settings file to be loaded.'$'\e''[[(reset)]m'$'\n'''$'\n''Document a function and generate a function template (markdown). To custom format any'$'\n''of the fields in this, write functions in the form '$'\e''[[(code)]m_documentationTemplateFormatter_$#6/690 - documentationTemplateCompile'$'\e''[[(reset)]m such that'$'\n''name matches the variable name (stringLowercase alphanumeric characters and underscores).'$'\n''Filter functions should modify the input/output pipe; an example can be found in '$'\e''[[(code)]mbin/build/tools/documentation.sh'$'\e''[[(reset)]m by looking at'$'\n''sample function '$'\e''[[(code)]m_documentationTemplateFormatter_return_code'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Template file not found'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateCompile template settingsFile'$'\n'''$'\n''    template      Required. A markdown template to use to map values. Post-processed with markdownRemoveUnfinishedSections'$'\n''    settingsFile  Required. Settings file to be loaded.'$'\n'''$'\n''Document a function and generate a function template (markdown). To custom format any'$'\n''of the fields in this, write functions in the form _documentationTemplateFormatter_$#6/690 - documentationTemplateCompile such that'$'\n''name matches the variable name (stringLowercase alphanumeric characters and underscores).'$'\n''Filter functions should modify the input/output pipe; an example can be found in bin/build/tools/documentation.sh by looking at'$'\n''sample function _documentationTemplateFormatter_return_code.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Template file not found'$'\n'''
documentationPath="documentation/source/tools/documentation.md"
