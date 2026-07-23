---
name: committer
description: Create clean, logically-grouped git commits. Use whenever the user asks to commit changes, types /commit, or just says "commit". Splits work into small ordered commits that each leave the repo in a working state, follows the repo's existing message conventions, and includes a body and footer when applicable.
user-invocable: true
argument-hint: "[optional scope or message hint]"
---

# `committer` skill

Turn the current pending changes into a series of **small, logically-ordered commits**
that follow the repository's own conventions — never one giant catch-all commit.

## When to run

Invoke this skill whenever the user:

- asks to commit something ("commit this", "commit my changes", etc.),
- types the `/commit` slash command, or
- simply says "commit".

## Step 1 — Inspect the working tree

Enumerate **everything** that is pending before deciding how to split it:

```bash
git status                       # staged, unstaged, and untracked overview
git diff                         # unstaged changes
git diff --staged                # already-staged changes
git ls-files --others --exclude-standard   # new untracked files
```

Read the actual diffs — don't guess from filenames. You need to understand what each
change does in order to group and order the commits correctly.

## Step 2 — Learn the repo's commit convention

Never impose a style the repo doesn't already use. Detect the existing one:

```bash
git log --oneline -n 30          # scan subject-line style at a glance
git log -n 10                    # read full messages: bodies, footers, trailers
```

Match what you find:

- **Message style** — Conventional Commits (`feat:`, `fix:`, `chore(scope):`) vs plain
  imperative subjects vs anything else the repo favors.
- **Casing, prefixes, scopes, ticket references** — mirror the dominant pattern.
- **Body and footer habits** — whether bodies wrap at ~72 chars, how footers/trailers
  (issue refs, `Co-authored-by`, `BREAKING CHANGE:`) are formatted.

If the history is empty or inconsistent, default to Conventional Commits with an
imperative subject.

## Step 3 — Group into small, ordered commits

Batch changes **per unit of work**, then order those batches so the repository stays
working at every step:

- **One concern per commit.** A refactor, a new feature, a bug fix, and a docs tweak
  are separate commits even if they were edited together.
- **Respect dependency order — every commit must build/work if you stopped there, and
  the last commit is always in a working state.** If `a.ts` was created and then `b.ts`
  imports from `a.ts`, commit `a.ts` *first*, then `b.ts`. Never land a commit that
  references code introduced by a later commit.
- **Stage each group explicitly**, then commit before staging the next:

  ```bash
  git add path/to/a.ts                 # stage only this group's files
  git add -p path/to/mixed-file.ts     # split a single file across commits when needed
  git commit -F <message-file>
  ```

  Prefer explicit paths (and `git add -p` for partial-file splits). **Never `git add .`
  blindly** — it defeats the grouping.

## Step 4 — Write the message

For every commit:

- **Subject** — in the repo's detected convention, imperative mood, concise.
- **Body (always include one)** — explain the *why* and any context that isn't obvious
  from the diff, wrapped to the repo's width.
- **Footer (when applicable)** — issue/ticket references, `BREAKING CHANGE:` notes,
  `Co-authored-by:` and similar trailers.

Use `git commit -F <file>` (or repeated `-m` flags) so multi-line bodies and footers are
preserved correctly.

## Step 5 — Handle WIP / uncertain changes

Before committing, flag anything that looks like work-in-progress or doesn't belong:

- leftover debug output (`console.log`, `print`, `dbg!`), commented-out code,
- `TODO` / `FIXME` markers added in this change,
- secrets or local config (`.env`, credentials, tokens),
- unrelated scratch files or experiments.

**Ask the user first** whether to include or leave out such changes — do not commit them
silently, and do not silently drop them either.

## Guardrails

- **Never `push`** unless the user explicitly asks.
- **Never `git add .`** blindly — stage per group.
- Don't amend or rewrite existing history unless asked.
- After committing, **report the resulting commit sequence** (subjects in order) back to
  the user so they can confirm the grouping.
