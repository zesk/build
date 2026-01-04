#!/usr/bin/env bash
# Colon-separated list of colors for the prompt
# Format: colon-separated-list
#
# Colors are escape codes. Last entry is a reset simply to make environment output less messy.
#
# 1. Success color
# 2. Failure color
# 3. User
# 4. Host
# 5. Path
#
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Decoration
# See: bashPrompt
# Type: ColonDelimitedList
export BUILD_PROMPT_COLORS
BUILD_PROMPT_COLORS="${BUILD_PROMPT_COLORS-}"
