# Technical Decisions

## Why Riverpod
- better control over async
- no context dependency

## Why invalidate()
- guarantees UI refresh
- avoids stale AsyncData

## Why local history
- no indexer dependency
- faster UX

## Known limitations
- no incoming tx history
- no multi-account
