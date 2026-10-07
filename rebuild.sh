#!/bin/bash
# Rebuilds the web test version of every app into this folder.
# Usage (from anywhere): bash app-studio/test-site/rebuild.sh
set -euo pipefail

SITE="$(cd "$(dirname "$0")" && pwd)"
STUDIO="$(dirname "$SITE")"

for app in higher-or-lower timeline-game flag-quest real-or-ai split-it doodle-duel; do
  rm -rf "${SITE:?}/$app"
  # EXPO_PUBLIC_TEST_MODE=1: free Pro unlock and ad placeholders.
  # EXPO_PUBLIC_GUESS_URL empty: this site is public, so Doodle Duel keeps the
  # simulated guesser and strangers can't run up the AI bill.
  (cd "$STUDIO/$app" && EXPO_PUBLIC_TEST_MODE=1 EXPO_PUBLIC_GUESS_URL= CI=1 \
    npx expo export --platform web --output-dir "$SITE/$app" >/dev/null)
  # GitHub Pages serves each app from a subfolder, so its links must be relative.
  perl -0pi -e 's#src="/_expo/#src="./_expo/#; s#href="/favicon.ico"#href="./favicon.ico"#; s#</head>#<meta name="theme-color" content="\#0F1020" /><style>body{background:\#0F1020}</style></head>#' "$SITE/$app/index.html"
  rm -f "$SITE/$app/metadata.json"
  echo "built $app"
done
