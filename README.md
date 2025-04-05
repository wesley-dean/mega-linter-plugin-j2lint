# mega-linter-plugin-j2lint

[![MegaLinter](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/megalinter.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/megalinter.yml)
[![Dependabot Updates](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/dependabot/dependabot-updates)
[![Scorecard supply-chain security](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/scorecard.yml/badge.svg)](https://github.com/wesley-dean/mega-linter-plugin-j2lint/actions/workflows/scorecard.yml)


This is a MegaLinter plugin for Arista Networks' j2lint)

## Introduction

[MegaLinter](https://github.com/oxsecurity/megalinter) by
[OxSecurity](https://github.com/oxsecurity) is a linter tool that supports
various programming languages and file formats. This repository contains a
MegaLinter plugin for
[j2lint](https://github.com/aristanetworks/j2lint) by
[Arista Networks](https://github.com/aristanetworks/).

The `j2lint` tool is a linter for Jinja2 templates -- a templating language
used in many configuration management tools, such as Ansible and SaltStack.
It checks for common errors and best practices.

## Usage

To use this plugin, you need to have MegaLinter installed. Please refer to the
[MegaLinter documentation](https://nvuillam.github.io/megalinter/) for
installation instructions.

### MegaLinter Configuration

To use this plugin, add the following to your MegaLinter configuration:

```yaml
PLUGINS:
  - "https://raw.githubusercontent.com/wesley-dean/mega-linter-plugin-j2lint/refs/heads/main/mega-linter-plugin-j2lint/j2lint.megalinter-descriptor.yml
```

Simply adding the plugin to the `PLUGINS` section will cause MegaLiner to read
the descriptor and make it available for use.  However, depending on your
MegaLinter configuration, you may need to enable the linter in the `ENABLE_LINTERS`
section as well.  For example:

```yaml
ENABLE_LINTERS:
  - "PYTHON_J2LINT"
```
