#!/usr/bin/env bash
rm -rf .build/ test.*
set -a
source .env.prod-robot
bin/test.sh
