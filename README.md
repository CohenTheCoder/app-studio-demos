# App Studio test site

Playable web test versions of six apps, published with GitHub Pages:
**https://cohenthecoder.github.io/app-studio-demos/**

This repo holds only the built web apps (no source code) plus the `index.html` hub page that links to them. Each app runs in **test mode**: Pro unlocks for free, ads are placeholder boxes, and Doodle Duel uses a simulated AI.

## Updating it

After changing an app, ask Claude to **"update the test site"**. It rebuilds every app with `rebuild.sh`, then commits and pushes, and GitHub Pages republishes within a minute or two.
