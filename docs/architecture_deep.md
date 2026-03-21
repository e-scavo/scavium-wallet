# Deep Architecture

## Overview
SCAVIUM Wallet uses a feature-first modular architecture with Riverpod.

## Key Decisions
- Riverpod AsyncNotifier for RPC-driven state
- Invalidation instead of manual refresh
- Localized auto-refresh (Home only)

## Data Flow
UI → Controller → Repository → RPC → Blockchain → Response → State → UI

## Why this design
- predictable state
- testable controllers
- separation of concerns

## Trade-offs
- more boilerplate
- requires discipline in layering
