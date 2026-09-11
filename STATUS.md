# STATUS

Orientation doc for a fresh Claude session with no prior context on this repo. Written 2026-09-11.

## 1. Project overview

This is a personal collection of DNS/hosts-file domain lists used for ad blocking and
website filtering, currently used to feed **Pi-hole** servers. Confirmed directly from
`legacy/README.md`:

> This repository is my collection of domain host lists used for ad blocking and website
> filtering. I currently use these lists for Pihole servers.

It is not an app or tool with code to run — it's a data repo (plain domain lists) plus a
couple of small helper scripts and a GitHub Actions workflow.

## 2. Contents

- **`adlist.txt`** (~138,000 lines, ~3 MB) — the active blocklist: one domain per line,
  fed to Pi-hole as an ad/tracker block source.
- **`whitelist.txt`** (~443 lines) — domains explicitly allowed (Google/Microsoft
  telemetry endpoints needed for normal OS/app function, CDN/speed-test hosts, etc.).
- **`legacy/`** — deprecated Pi-hole 4-era list structure, kept for reference only:
  - `legacy/README.md` — the repo's actual description (quoted above).
  - `legacy/Blacklists/` — old `blacklist.list`.
  - `legacy/Blocklists/` — old `dbl-oisd-nl.list`, `firebog.list`,
    `the-block-list-project.list`, plus a `README.md` listing blocklist sources (oisd.nl
    used as primary source; firebog/blocklist.site noted as "reference only, not
    actually using them").
  - `legacy/Whitelists/` — old whitelist file/README.
- **`.github/workflows/`** — light automation, appears unfinished/unused in practice:
  - `cleanup-lists.yml` — GitHub Action triggered on push to `master` touching
    `**.list`/`**.txt`; runs `scan-duplicates.sh` and `verify-domains.sh`.
  - `scan-duplicates.sh` — sorts each `*.txt` and prints unique (non-duplicate) lines;
    doesn't actually write changes back to the list files.
  - `verify-domains.sh` — intends to ping each domain and comment out unreachable ones,
    but has a real bug: `for domain in file` iterates over the literal string `"file"`,
    not the file's contents, so it never actually checks any domain.
  - `logs/scan-duplicates.log`, `logs/verify-domains.log` — committed log output from
    past workflow runs.

There is **no top-level `README.md`** currently — one existed early on but was removed
during a "Rearranged files" commit (May 2024) and never re-added at the root; the closest
thing to a project description is `legacy/README.md`.

This looks hand-maintained (manual `git add`/edits and occasional bulk pastes of new
blocked domains), not driven by a script that pulls fresh lists from upstream sources on
a schedule — the GitHub Action exists but is minimal and at least partly broken
(`verify-domains.sh`'s domain loop).

## 3. Current status

Working tree is clean; branch `master` is up to date with `origin/master`. No uncommitted
changes.

Activity is sparse and irregular: long gaps between commits (whitelist/adlist tweaks in
2024, then a single stray commit in September 2026 — see below). This reads as a
low-maintenance personal utility repo Jason updates occasionally when he wants to add a
block/allow entry, not an actively developed project.

## 4. Recent history highlights (from `git log`)

- **e9b78c9** (Sep 4, 2026) "Updates to openvpn docs" — the message doesn't match the
  actual diff (it only strips a trailing newline from `adlist.txt`); looks like a
  copy-paste commit-message mistake from another project (pfSense OpenVPN work), not an
  actual docs update to this repo. Worth knowing if a future session is confused by it.
- **41556e8** (Oct 19, 2024) "Update adlist.txt" — added Amazon Prime Video ad-serving
  domains.
- **de2e417 / f175340** (May 2024) — added and then trimmed `whitelist.txt`.
- **61c2f22 / d280c5e** (May 24, 2024) — renamed `gravity.txt` → `adlist.txt`.
- **bb006f7 / 38c538e / dc20157 / 1871e33** (May 24, 2024) — a flurry of same-day
  restructuring: old `Blacklists/`, `Blocklists/`, `Whitelists/` directories deprecated
  and moved under `legacy/`, with one accidental revert-then-redo in the middle. This is
  the point where the repo moved from the old multi-source-list layout to the current
  simple `adlist.txt` + `whitelist.txt` layout.
- Earlier history (visible further back in `git log`) shows iterative tuning of
  `whitelist.list` and the `cleanup-lists.yml`/`scan-duplicates.sh`/`verify-domains.sh`
  automation, i.e. the GitHub Actions setup was built out gradually in 2024 and hasn't
  been touched since.

## 5. Pointers

- `legacy/README.md` — the only real project description in the repo.
- `legacy/Blocklists/README.md` — notes on blocklist sources (oisd.nl is the primary
  upstream source historically used to build the list; firebog/blocklist.site are noted
  as reference-only, not actually consumed).
- `.github/workflows/` — the (partly broken) automation described above; check here
  before assuming any list-hygiene tooling actually runs correctly.
- No `.env`, no build tooling, no test suite — nothing else to configure or run.
