# ADR-003: Consolidate GitHub Actions Dependabot Version Updates

Date: 2026-11-12

## Status

Accepted

## Decision

Retain weekly Dependabot version updates for the GitHub Actions ecosystem
and the existing seven-day cooldown, changing the `minor-and-patch` group
to `actions-version-updates`, explicitly `applies-to: version-updates`
with `patterns: ["*"]` and no `update-types` restriction. Eligible major,
minor, and patch routine changes may be grouped.

Keep security updates independent and timely. Preserve the existing
non-major-only automatic merge check using `dependabot/fetch-metadata`;
major-containing groups must receive manual review with evidence for all
affected dependencies and their permissions.

## Context and Assumptions

The existing minor/patch-only group separates major versions into other
PRs, increasing recurring maintenance overhead. The verified
`coding_standards@v3.2.0` release recommends a broad weekly group and
seven-day cooldown, while retaining risk-based review of major upgrades.

This plugin deliberately pins `j2lint==1.2.0` under ADR-001. Its Python
transitive dependencies are not fully locked; the plugin behavior and
`PYTHON_J2LINT` interface are tested with separate positive and negative
Jinja fixture runs. ADR-002 requires versioned descriptor releases, exact
source commit provenance, and publication privilege separation.
Neither accepted decision is changed by grouping workflow updates.

Only GitHub Actions is configured for Dependabot. Workflow permissions,
release tokens, checks, and existing commit-message conventions remain.
Effective rulesets, CODEOWNERS review enforcement, and security update
settings are external to YAML and need independent verification.

## Alternatives Considered

- Keep minor/patch grouping: rejected as the default due to continuing
  separate major PR overhead without inherently stronger review.
- Group all eligible routine versions per ecosystem: selected, with
  explicit manual scrutiny for major-containing changes.
- Use monthly updates or longer cooldowns: rejected without activity or
  risk evidence justifying delayed version visibility.
- Auto-merge major-containing groups: rejected due to compatibility,
  workflow-authority, and release-provenance risks.
- Close existing PRs on reconfiguration: rejected because their
  replacements and test coverage are not established.

## Consequences, Verification, and Compatibility

Fewer routine PRs may result; there is no promise of a particular count.
A grouped dependency conflict may require a narrow, documented exception.
Every changed GitHub Action still needs review for release notes, trust
boundaries, permissions, migrations, and meaningful test results. A green
lint job alone does not establish the generated descriptor or publishing
contract remains safe.

Open Dependabot PR #77 remains open until a subsequent group demonstrably
covers its update and receives sufficient CI evidence. Observe future
Dependabot runs, confirm major groups are held out of auto-merge, and
verify effective security and review settings independently.

The change does not modify runtime source, the j2lint package pin,
tested Jinja extensions, generated artifact filenames, descriptor
publication authority, or public compatibility contracts.

## Related Decisions

ADR-001 governs pinned j2lint integration and behavior. ADR-002 governs
validated release descriptor assets and publication. Both remain binding.
