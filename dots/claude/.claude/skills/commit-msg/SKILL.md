---
name: commit-msg
description: >
  Commit message generator. Cuts noise while preserving intent and reasoning.
  Subject ≤50 chars, body only when "why" isn't obvious. Use when user says
  "write a commit", "commit message", "generate commit", "/commit", or invokes
  /commit-msg. Auto-triggers when staging changes.
---

Write commit messages terse and exact. No fluff. Why over what.

## Rules

**Subject line:**
- `TICKET-REFERENCE: <imperative summary>` - ticket reference should be in the branch name, if not, ask the user.
- Imperative mood: "add", "fix", "remove" — not "added", "adds", "adding"
- ≤50 chars when possible, hard cap 72
- No trailing period
- Match project convention for capitalization after the colon

**Body (only if needed):**
- Skip entirely when subject is self-explanatory
- Add body only for: non-obvious *why*, breaking changes, migration notes, linked issues
- Wrap at 72 chars
- Bullets `-` not `*`

**What NEVER goes in:**
- Conventional Commits format, convention on the branch, not the commit.
- "This commit does X", "I", "we", "now", "currently" — the diff says what
- "As requested by..." — use Co-authored-by trailer
- "Generated with Claude Code" or any AI attribution
- Emoji
- Restating the file name when scope already says it
- avoid HEREDOC syntax in favor of multiline strings

## Examples

Diff: new endpoint for user profile with body explaining the why
- ❌ "feat: add a new endpoint to get user profile information from the database"
- ✅
  ```
  TICKET-123: add GET /users/:id/profile

  Mobile client needs profile data without the full user payload
  to reduce LTE bandwidth on cold-launch screens.
  ```

Diff: breaking API change
- ✅
  ```
  TICKET-345: rename /v1/orders to /v1/checkout

  BREAKING CHANGE: clients on /v1/orders must migrate to /v1/checkout
  before 2026-06-01. Old route returns 410 after that date.
  ```

## Auto-Clarity

Always include body for: breaking changes, security fixes, data migrations, anything reverting a prior commit. Never compress these into subject-only — future debuggers need the context.

## Boundaries

Only generates the commit message. Does not run `git commit`, does not stage files, does not amend. Output the message as a code block ready to paste. "stop caveman-commit" or "normal mode": revert to verbose commit style.
