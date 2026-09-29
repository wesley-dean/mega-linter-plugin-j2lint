#!/usr/bin/env bats

setup() {
  DESCRIPTOR="${BATS_TEST_DIRNAME}/../mega-linter-plugin-j2lint/j2lint.megalinter-descriptor.yml"
}

@test "descriptor pins the reviewed j2lint release" {
  grep -Fq 'RUN pip3 install --no-cache-dir j2lint==1.2.0' "${DESCRIPTOR}"
}

@test "descriptor identifies the upstream linter repository" {
  grep -Fq 'linter_repo: "https://github.com/aristanetworks/j2lint"' "${DESCRIPTOR}"
  grep -Fq 'linter_url: "https://github.com/aristanetworks/j2lint"' "${DESCRIPTOR}"
}

@test "descriptor pins upstream rule documentation to j2lint 1.2.0" {
  grep -Fq 'ba3ae401e723b8e359ea675274d6733340f96582/README.md#syntax-and-code-style-issues' "${DESCRIPTOR}"
  grep -Fq 'ba3ae401e723b8e359ea675274d6733340f96582/README.md#ignoring-rules' "${DESCRIPTOR}"
}

@test "descriptor exposes list_of_files mode only" {
  grep -Fq 'cli_lint_mode: "list_of_files"' "${DESCRIPTOR}"
  grep -Fq 'supported_cli_lint_modes:' "${DESCRIPTOR}"
  grep -Fq '      - "list_of_files"' "${DESCRIPTOR}"
}

@test "descriptor counts both errors and warnings from j2lint summary output" {
  grep -Fq 'cli_lint_errors_count: "regex_number"' "${DESCRIPTOR}"
  grep -Fq 'cli_lint_warnings_count: "regex_number"' "${DESCRIPTOR}"
  grep -Fq 'Jinja2 linting finished with ([0-9]+) error' "${DESCRIPTOR}"
  grep -Fq 'and ([0-9]+) warning' "${DESCRIPTOR}"
}
