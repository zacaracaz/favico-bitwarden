# Security

This tool edits your Bitwarden vault, so here's exactly what it does and how to verify it.

## What it accesses
- Your vault is decrypted **only on your machine**, by the **official Bitwarden CLI**
  (`bw`), using the session you unlock. The tool shells out to `bw`; it never
  re-implements Bitwarden's crypto and never handles your master password (you type
  it straight into `bw unlock`).
- Vault data lives **only in memory** for the duration of the run and is gone when the
  process exits. The only file written is an **encrypted** backup in `backups/`.

## What leaves your machine
- **`icons.bitwarden.net`** — each entry's *domain*, to check whether a favicon exists
  (Bitwarden already stores your vault).
- **`www.favico.app`** — brand-name guesses from your domains, anything you type in a
  search box, and any image you upload/crop (stored as an icon).
- **Opt-in only** (a toggle on the first screen, off by default): anonymous
  `old → new` rename hints, `domain → icon` matches, library-search picks, and
  icon-usage counts — to improve matching for everyone. **No identifiers, URLs,
  passwords, or full entries.**

## What never leaves your machine
- **Passwords and all other secret fields.** The optional "compare passwords to spot
  duplicates" step runs **entirely locally** and only ever yields a true/false — the
  value is never shown, stored, or sent.
- Vault edits, renames, deletions, and the encrypted backup go only between your
  machine and Bitwarden via the CLI.

## Verify it yourself
It's plain, un-compiled JavaScript with **no third-party dependencies** (only Node
built-ins + the `bw` CLI), and the web UI is **inline** — nothing is loaded from a CDN.
The whole surface is `start.mjs` and `scripts/bw-favico-ui.mjs`:

```bash
grep -nE "fetch\(" scripts/bw-favico-ui.mjs      # every outbound request
grep -niE "password" scripts/bw-favico-ui.mjs     # never sent over the network
grep -noE "https?://[a-z0-9./-]+" scripts/bw-favico-ui.mjs | sort -u   # hosts contacted
```

You should only ever see `icons.bitwarden.net`, `www.favico.app`, and `localhost`.

## Safety nets
- An **encrypted backup** is made before any change (`backups/`).
- **Nothing is written** to your vault until the final Apply step.
- Removals are **soft-deleted to Bitwarden's Trash** (recoverable), never permanent.
- The wizard has a **"Revert all favico URIs"** button that undoes everything it added.

## Reporting a vulnerability
Please email **support@favico.app** with details. This was built with AI assistance by
someone who isn't a security professional — careful review and responsible disclosure
are very welcome.
