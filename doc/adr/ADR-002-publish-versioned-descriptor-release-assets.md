# ADR-002: Publish Versioned j2lint Descriptor Release Assets

Date: 2026-09-29

## Status

Accepted

## Context

The repository already publishes GitHub releases with `v`-prefixed semantic
versions, most recently `v0.0.22`, but historical releases contain no plugin
descriptor assets.  Documentation previously directed consumers to the mutable
descriptor on `main`.

A MegaLinter plugin descriptor is executable configuration because it can define
installation commands and runtime behavior.  Normal consumers therefore benefit
from a reviewed, versioned distribution boundary.

## Decision Drivers

- Consumers should be able to pin an immutable plugin descriptor version.
- Consumers who intentionally follow releases should have a stable latest-release
  URL distinct from `main`.
- The exact distributed descriptor bytes should be validated before publication.
- Publication authority should be isolated from jobs that execute repository
  source and plugin tests.
- Existing `v`-prefixed release numbering should remain compatible.

## Decision

Every future GitHub release SHALL include:

```text
j2lint.megalinter-descriptor.yml
j2lint.megalinter-descriptor.yml.sha256
```

The release build SHALL generate the distributed descriptor from the maintained
descriptor, record the `v`-prefixed release version and exact 40-character
source commit SHA in YAML comments, and generate the accompanying SHA-256
checksum.

The generated descriptor SHALL retain the `j2lint==1.2.0` installation pin
established by ADR-001 until a later reviewed change updates that integration
boundary.

Release validation SHALL test the generated descriptor itself, including schema
validation, checksum verification, a passing fixture, and a failing fixture
through MegaLinter.

Only after validation succeeds SHALL a separate publication job receive the
release files.  That job SHALL re-verify the exact file set and checksum before
creating the GitHub release.

The repository SHALL preserve its existing `vX.Y.Z` release tag convention.

Documentation SHALL recommend a version-pinned release asset for reproducible CI:

```text
https://github.com/wesley-dean/mega-linter-plugin-j2lint/releases/download/vX.Y.Z/j2lint.megalinter-descriptor.yml
```

Documentation MAY also offer the following URL when a consumer intentionally
wants the newest published plugin release:

```text
https://github.com/wesley-dean/mega-linter-plugin-j2lint/releases/latest/download/j2lint.megalinter-descriptor.yml
```

MegaLinter validates the configured plugin string before downloading it.  Both
documented HTTPS forms satisfy the required `/mega-linter-plugin-` substring
because the repository name is `mega-linter-plugin-j2lint`.

Local integration testing SHALL stage a byte-identical copy of the generated
descriptor beneath a temporary `mega-linter-plugin-` directory because the
natural `file://dist/...` path does not satisfy MegaLinter's local-plugin path
check.  That staging path is a test accommodation and does not change the public
release artifact filename.

## Alternatives Considered

### Continue Recommending main

Rejected because branch content is mutable and does not represent an explicit
release decision.

### Publish Releases Without Descriptor Assets

Rejected because the GitHub Release would remain disconnected from the
configuration MegaLinter actually consumes.

### Build and Publish in One Privileged Job

Rejected because validation does not require release-publishing authority.
Separating those capabilities narrows the publication trust boundary.

## Consequences

### Positive

- Consumers can pin plugin descriptor versions.
- The latest-release URL follows releases rather than development state.
- Published descriptor bytes are tested before publication.
- Release assets include an integrity checksum and source provenance comments.
- Existing release naming remains consistent.

### Negative

- Release automation becomes more involved.
- Historical releases remain asset-less unless deliberately backfilled.
- A checksum distributed beside an asset detects byte changes but is not an
  independent authentication mechanism.

## Compatibility and Migration

Existing release tags remain untouched.  Existing consumers of the raw `main`
descriptor continue to work, but documentation now recommends release assets.

This feature-bearing change follows `v0.0.22`, so the expected next semantic
release is `v0.1.0`, subject to the reviewed merge title and release workflow.

## Expected Outcome

Consumers can choose explicitly between a version-pinned j2lint plugin and
automatic adoption of newly published plugin releases without following
development state.
