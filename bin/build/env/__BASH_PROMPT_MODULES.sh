#!/usr/bin/env bash
# Name: Prompt module list
# Summary: List of functions to run each prompt command
# List of modules to run each prompt command.
#
# Manage with `bashPrompt functionName` to add, `bashPrompt --remove functionName` to remove.
#
# Make your functions *really* fast otherwise the shell becomes sluggish. Also try:
#
#     BUILD_DEBUG=bashPrompt
#
# To report on each command and timing.
#
# An automatic reporting occurs when commands exceed 0.3s.
#
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Bash Prompt
# Type: Array:Callable
# See: bashPrompt
__BASH_PROMPT_MODULES=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")
