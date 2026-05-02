# Validation Commands — SCAVIUM Wallet

## IMPORTANT

All commands are executed manually by the user.

The agent MUST NOT execute any commands.

---

## Analyze

```bash
fvm flutter analyze
```

---

## Scoped Test

```bash
fvm flutter test test/build_tool_version_test.dart
```

---

## Optional Format

```bash
dart format tool/build.dart test/build_tool_version_test.dart
```

---

## Full Test (only at phase closure)

```bash
fvm flutter test
```

---

## Fallback

```bash
dart run tool/build.dart --check-version --expected-tag v0.2.2
fvm flutter test test/build_tool_version_test.dart
fvm flutter analyze
```

---

## Git — Accumulative Phase Branch

```bash
git checkout main
git pull
git checkout -b phase-9.2-build-version-msix-sync-hardening

git status
git add <modified-files>
git commit -m "phase 9.2 build version msix synchronization hardening"

git checkout main
git pull
git merge phase-9.2-build-version-msix-sync-hardening
git branch -d phase-9.2-build-version-msix-sync-hardening
```
