#!/usr/bin/env bash

set -euo pipefail

docker run \
  --rm \
  -it \
  -v "$(pwd):/tmp/lint" \
  -w "/tmp/lint" \
  -e VALIDATE_ALL_CODEBASE=true \
  -e REPORT_OUTPUT_FOLDER=none \
  -e DISABLE_ERRORS=true \
  -e PRINT_ALPACA=false \
  -e PLUGINS="[\"file://mega-linter-plugin-j2lint/j2lint.megalinter-descriptor.yml\"]" \
  -e ENABLE_LINTERS="[\"PYTHON_J2LINT\"]" \
  -e MEGALINTER_FILES_TO_LINT="[\"test/good.j2\",\"test/bad.j2\"]" \
  docker.io/oxsecurity/megalinter-ci_light:latest
