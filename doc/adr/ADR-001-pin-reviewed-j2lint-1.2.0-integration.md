# ADR-001: Pin the Reviewed j2lint 1.2.0 Integration

Date: 2026-09-29

## Status

Accepted

## Context

This repository exposes Arista Networks' j2lint through MegaLinter.  The
descriptor previously installed the floating PyPI requirement `j2lint`, so a
new upstream release could change plugin behavior without any commit or review in
this repository.

The reviewed upstream release is j2lint 1.2.0.  Its source tag resolves to commit
`ba3ae401e723b8e359ea675274d6733340f96582`.  The 1.2.0 command-line interface accepts files and
directories directly, recognizes `.j2`, `.jinja`, and `.jinja2` by default,
reports aggregate error and warning counts, and returns a non-zero status when
lint errors are present.

Upstream j2lint remains active.  Pinning 1.2.0 is therefore a reviewed integration
boundary, not a claim that this project will remain on 1.2.0 permanently.

## Decision Drivers

- Plugin behavior should change only through reviewed repository changes.
- Existing users should retain the `PYTHON_J2LINT` MegaLinter key and supported
  file extensions.
- Integration tests should prove observable pass/fail behavior.
- Descriptor metadata should identify the actual upstream linter.
- Upstream rule documentation used by this plugin version should be immutable.
- This repository should not pretend to provide a fully locked Python dependency
  graph unless it can reproducibly generate and maintain one.

## Decision

The descriptor SHALL install `j2lint==1.2.0`.

The descriptor SHALL identify `https://github.com/aristanetworks/j2lint` as the
upstream linter repository and URL.  Rule and inline-disable documentation links
SHALL point to the immutable source commit for j2lint 1.2.0.

MegaLinter `list_of_files` mode SHALL be the only declared supported lint mode.
The descriptor SHALL count both errors and warnings from j2lint's aggregate
summary output.

Integration testing SHALL invoke a repository-owned passing fixture and failing
fixture separately with MegaLinter errors enabled.  The passing fixture SHALL
return success, and the failing fixture SHALL produce a non-zero MegaLinter
result.

A future j2lint release SHALL be adopted through an explicit plugin change with
review and integration testing.

This decision pins the top-level j2lint package only.  j2lint 1.2.0 declares
compatible ranges for transitive Python dependencies.  Those transitives may
therefore resolve to different compatible releases over time.  A future decision
to maintain a fully hashed dependency closure requires reproducible lockfile
generation and its own maintenance policy rather than a hand-maintained list.

## Alternatives Considered

### Continue Installing Unversioned j2lint

Rejected because it permits upstream release changes to alter plugin behavior
without a plugin commit.

### Follow Upstream's Development Branch

Rejected because development state is not a released integration boundary.

### Maintain a Hand-Written Fully Hashed Dependency Closure

Rejected for the current scope.  A trustworthy hash-locked environment should be
generated reproducibly by dependency tooling, not assembled manually from
package indexes.

### Vendor j2lint

Rejected because upstream is active and there is no current need to assume
ownership of its source or release process.

## Consequences

### Positive

- The top-level linter version is deterministic and reviewable.
- Upstream metadata and documentation links reflect the implementation actually
  being integrated.
- Tests protect both successful and failing behavior.
- Future upstream upgrades become explicit maintenance events.

### Negative

- Compatible transitive Python dependencies remain mutable.
- A future j2lint release requires a plugin update rather than automatic
  adoption.
- Changes in compatible transitive dependencies could still affect behavior and
  may motivate a later lockfile decision.

## Compatibility and Migration

The public MegaLinter key remains `PYTHON_J2LINT`.  The descriptor path remains
`mega-linter-plugin-j2lint/j2lint.megalinter-descriptor.yml`, and the supported
extensions remain `.j2`, `.jinja`, and `.jinja2`.

## Expected Outcome

The plugin provides a stable, explicitly reviewed MegaLinter integration for
j2lint 1.2.0 while keeping future upstream upgrades visible and testable.
