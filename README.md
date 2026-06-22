# favico × Bitwarden

A small, **local** tool that gives your Bitwarden / Vaultwarden logins real icons.

It adds `name.favico.app` as an entry's first URI with **match = Never**, so Bitwarden
shows that favicon while your real URL just moves down and **autofill is unaffected**.
Along the way it can suggest cleaner entry names and flag likely-duplicate logins.

## Run it

The only thing you must already have is a **Bitwarden account** — the launcher
offers to install everything else it needs:

- **Node.js** — if it's missing, the wrapper installs it for you: `start.cmd`
  uses **winget** (Windows); `start.sh` uses **Homebrew / apt / dnf / pacman**
  (macOS/Linux). Each asks first.
- **Bitwarden CLI** — `start.mjs` offers to install it via **npm** if missing.

Then just:

- **Windows:** double-click **`start.cmd`**
- **macOS / Linux:** run **`./start.sh`**
- **Any OS (Node already installed):** `node start.mjs`

The launcher walks you through everything, narrating each step: installs/checks
prerequisites, logs you in only if needed, unlocks your vault (your master
password stays hidden), makes an **encrypted backup**, and opens a 6-step wizard
in your browser.

> On Windows, the very first run after a fresh Node install may say *"Node was
> installed but this window needs reopening"* — just close it and double-click
> `start.cmd` again (a one-time PATH refresh).

If you'd rather install the prerequisites yourself: Node.js from
<https://nodejs.org>, then `npm install -g @bitwarden/cli`.

## What the wizard does

1. **Matched** — entries with no icon that auto-matched (pre-selected).
2. **Pick icons** — no match: search the library, search the web, or upload one.
3. **Replace** — optionally swap an entry's existing icon.
4. **Rename** — cleaner names for URL/package-style entries.
5. **Duplicates** — logins grouped by site + username; tick any to move to Trash.
6. **Review & apply** — full summary + a downloadable change record, then apply.

Nothing is written to your vault until the final **Apply** step.

## Safety & privacy

- Runs **entirely on your machine**. Your vault is decrypted locally via the
  official Bitwarden CLI — **your master password and secrets never leave it**.
- An **encrypted backup** is written before anything changes.
- Duplicate removal **soft-deletes to Bitwarden's Trash** (recoverable), never permanent.
- The only servers contacted are **`icons.bitwarden.net`** (to check existing
  favicons) and **`www.favico.app`** (icon search / upload). Nothing else.
- Icons you **upload or pick from a web search are stored on the favico.app
  server** and added to its shared, searchable library (by design, for reuse) —
  they contain only the image and the short name you give it, **no vault data**.

## Verify it yourself

It's plain, un-compiled JavaScript with **no third-party dependencies** (only
Node built-ins + the official `bw` CLI), and the web UI is **inline** — nothing
is loaded from a CDN. The whole thing to audit is `start.mjs` and
`scripts/bw-favico-ui.mjs`. A quick check:

```
grep -nE "fetch\(" scripts/bw-favico-ui.mjs        # every outbound request
grep -niE "password" scripts/bw-favico-ui.mjs       # never sent over the network
```

## License & name

Licensed under the **PolyForm Noncommercial License 1.0.0** (see [LICENSE.md](LICENSE.md)):
free to use, self-host, modify, and share for **non-commercial** purposes —
**commercial use is not permitted**.

The name **"favico"** and the funnel logo are reserved by the author and are **not**
covered by the code license.
