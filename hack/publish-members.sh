#!/bin/sh
set -eu

ROOT="${1:-..}"
STATE="$ROOT/qod-state/revisions"

[ -d "$STATE" ] || { echo "publish-members: no revisions at $STATE; run the workspace pipeline first" >&2; exit 1; }

RECORD=$(ls -t "$STATE"/*.json 2>/dev/null | head -1)
[ -n "$RECORD" ] || { echo "publish-members: no revision; run the workspace pipeline first" >&2; exit 1; }

PROVENANCE=$(basename "$RECORD" .json)
echo "publish-members: provenance $PROVENANCE"

publish() {
    repo="$1"

    version=$(git -C "$ROOT/$repo" describe --tags --abbrev=0 2>/dev/null || true)
    if [ -z "$version" ]; then
        count=$(printf %08d "$(git -C "$ROOT/$repo" rev-list --count HEAD)")
        sha=$(git -C "$ROOT/$repo" rev-parse --short=12 HEAD)
        version="v0.1.0-dev.r$count.g$sha"
    fi

    forge-register publish --provenance "$PROVENANCE" \
        --source "git@github.com:alexandremahdhaoui/$repo.git" \
        "internal:github.com/alexandremahdhaoui/$repo" "$version"
}

for repo in qod-core qod-app qod-engines qod-configgen qod-spec; do
    [ -d "$ROOT/$repo/.git" ] || continue
    publish "$repo"
done

echo "publish-members: every member is on the internal track at $PROVENANCE"
