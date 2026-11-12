# Architectural Decisions

This file summarizes Accepted ADRs. Consult the complete ADRs when this
summary is incomplete; applicable released standards and explicit local
policy also govern repository work.

## ADR-001: Pin the Reviewed j2lint 1.2.0 Integration

The plugin pins `j2lint==1.2.0` and retains the `PYTHON_J2LINT` key
and supported Jinja file extensions. It uses the tested list-of-files
integration, with separately executed passing and failing fixtures.
An upgrade to the upstream tool requires explicit review.

See [ADR-001](adr/ADR-001-pin-reviewed-j2lint-1.2.0-integration.md).

## ADR-002: Publish Versioned j2lint Descriptor Release Assets

Normal consumers use validated versioned descriptor assets rather than
mutable development state. Generated descriptors include source-commit
provenance and a SHA-256 companion, and a separate publication job
re-verifies the validated bytes before releasing them.

See [ADR-002](adr/ADR-002-publish-versioned-descriptor-release-assets.md).

## ADR-003: Consolidate GitHub Actions Dependabot Version Updates

Routine GitHub Actions version updates remain weekly with seven-day
cooldown and a wildcard major/minor/patch group. Security updates remain
independent, while groups with a major version are excluded from the
existing non-major-only auto-merge route and require manual review.

See [ADR-003](adr/ADR-003-consolidate-github-actions-dependabot-maintenance.md).
