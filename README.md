# mega-linter-plugin-j2lint

[![MegaLinter](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/megalinter.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/megalinter.yml)
[![Dependabot Updates](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/dependabot/dependabot-updates)
[![Scorecard supply-chain security](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/scorecard.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/scorecard.yml)

This repository provides a MegaLinter plugin for
[j2lint](https://github.com/aristanetworks/j2lint) by Arista Networks.

j2lint checks Jinja2 templates for syntax and code-style issues.  This plugin
release intentionally pins j2lint 1.2.0, the upstream release reviewed and tested
for this integration.  A newer upstream release should be adopted through an
explicit plugin change rather than silently through an unversioned PyPI install.

## MegaLinter Configuration

Released descriptors are the supported distribution channel for normal
MegaLinter use.  For reproducible CI and production workflows, pin the plugin to
a specific release:

```yaml
PLUGINS:
  - "https://github.com/wesley-dean/mega-linter-plugin-j2lint/releases/download/v0.1.0/j2lint.megalinter-descriptor.yml"
```

When deliberately following the newest released plugin version, use the
latest-release asset:

```yaml
PLUGINS:
  - "https://github.com/wesley-dean/mega-linter-plugin-j2lint/releases/latest/download/j2lint.megalinter-descriptor.yml"
```

Pinning a release is preferred when build reproducibility matters.  The
`releases/latest/download/` form trades that reproducibility for automatic
adoption of newly published plugin releases.

Depending on the rest of the MegaLinter configuration, explicitly enable the
linter when necessary:

```yaml
ENABLE_LINTERS:
  - "PYTHON_J2LINT"
```

The plugin applies to `.j2`, `.jinja`, and `.jinja2` files and invokes
j2lint in MegaLinter's `list_of_files` mode.

## Upstream Version

The descriptor installs:

```text
j2lint==1.2.0
```

That pin protects this plugin from silently changing when Arista publishes a new
j2lint release.  j2lint 1.2.0 itself declares compatible version ranges for its
Python dependencies, so its transitive dependency resolution is not a fully
locked Python environment.  ADR-001 records that tradeoff explicitly.

Rule documentation links in the descriptor are pinned to the source commit for
j2lint 1.2.0 rather than following upstream's development branch.

## Releases

Each plugin release publishes:

```text
j2lint.megalinter-descriptor.yml
j2lint.megalinter-descriptor.yml.sha256
```

The distributed descriptor records the plugin release version and exact source
commit that produced it.  It retains the explicit `j2lint==1.2.0` installation
pin.

Release validation exercises the generated descriptor through MegaLinter before
publication.  The validated files cross into a separate publication job, where
the exact file set and checksum are verified again before GitHub creates the
release.

The descriptor stored on `main` remains useful for plugin development and
testing, but normal consumers should use a release asset rather than development
state.

## Development

Behavioral tests use deterministic local Jinja2 fixtures.  The passing and
failing cases are invoked separately so a failing fixture cannot be hidden by
`DISABLE_ERRORS=true`.

Useful targets are:

```bash
make test
make validate
make build
make validate-release
make integration-test
make clean
```

`make test` runs Bats assertions for the descriptor and release build.
`make validate` validates the maintained descriptor against the schema from
MegaLinter 10.1.0.  `make integration-test` loads the generated descriptor
through MegaLinter 10.1.0 and verifies that the good fixture passes while the
bad fixture fails.

For a local release-style build:

```bash
make build VERSION=0.1.0 BUILD_REF="$(git rev-parse HEAD)"
```

## Repository Governance

This repository adopts released engineering standards from
[`wesley-dean/coding_standards`](https://github.com/wesley-dean/coding_standards).
The complete pinned snapshot is committed beneath `doc/standards/`, while
`.codingstandardrc` records the adopted release and verified archive digest.

Applicable files beneath `doc/standards/` are project requirements, subject to
accepted repository-specific ADRs and explicit local policy.  Imported standards
are managed as a release snapshot and are not edited locally to create
project-specific exceptions.
