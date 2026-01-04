#!/usr/bin/env bash
# Sound for notifications. Set to `-` for no sound. Defaults to `zesk-build-notification`.
# See: darwinNotification
# Type: String
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
export BUILD_NOTIFY_SOUND
BUILD_NOTIFY_SOUND="${BUILD_NOTIFY_SOUND-zesk-build-notification}"
