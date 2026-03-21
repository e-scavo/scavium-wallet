# Phase 6 — Packaging, Branding, Release, and Store Deployment

## Overview

Phase 6 focuses on transitioning SCAVIUM Wallet from a **functionally complete and production-ready application** (Phases 1 → 5.5.6) into a **distribution-ready product** across all supported platforms.

This phase strictly covers:

- Application packaging
- Platform configuration
- Signing and certificates
- Branding and visual identity
- Build generation
- Store preparation (Play Store / App Store)

⚠️ No functional wallet changes are introduced in this phase.

---

## Phase 6.5 — Cross-Platform Branding Baseline

### Objective

Establish a **single, consistent branding foundation** across all platforms before platform-specific packaging begins.

This ensures:

- Visual consistency
- Asset reuse across platforms
- Simplified maintenance
- Predictable build outputs

---

## Branding Principles

- Consistency over customization
- Single source of truth for assets
- Platform adaptation without altering identity
- No runtime branding logic (compile-time assets only)

---

## App Identity

### App Name (Display)

- SCAVIUM Wallet

### Internal Name

- scavium_wallet

### Package / Bundle (already defined — DO NOT MODIFY unless required per platform)

- Android: com.geryon.scavium_wallet
- iOS: com.geryon.scaviumWallet

---

## Color System (Baseline)

Primary color must match Phase 5 UI:

- Primary: #00C2FF (example — confirm from theme)
- Background: dark-first (as per current UI)
- Accent: derived from primary (no new palette introduced)

⚠️ Do NOT redefine theme system — reuse app_colors.dart.

---

## Typography

- Defined via google_fonts (already integrated)
- No changes in this phase
- Ensure consistency across splash and platform launch screens

---

## Asset Inventory

All branding assets must originate from a single source directory:

assets/branding/

---

### Required Assets

#### 1. App Icon (Master)

- File: app_icon_master.png
- Resolution: 1024x1024
- No transparency issues
- No rounded corners (platforms will apply masks)

---

#### 2. Adaptive Icon (Android)

Foreground:
app_icon_foreground.png (1024x1024, transparent background)

Background:
app_icon_background.png (solid color or gradient)

---

#### 3. Splash Logo

splash_logo.png (512x512 or 1024x1024)

Centered, minimal padding

---

#### 4. Web Icons

- favicon.png (32x32)
- icon-192.png
- icon-512.png

---

#### 5. Windows Icon

app_icon.ico (multi-resolution: 16, 32, 48, 256)

---

## Asset Generation Rules

- Always export from master (1024x1024)
- Maintain aspect ratio
- Avoid re-scaling from already scaled assets
- Keep file names stable (no renaming later)

---

## Folder Structure (Final)

assets/
  branding/
    app_icon_master.png
    app_icon_foreground.png
    app_icon_background.png
    splash_logo.png
    web/
      favicon.png
      icon-192.png
      icon-512.png
    windows/
      app_icon.ico

---

## Flutter Integration

Ensure assets are registered:

flutter:
  assets:
    - assets/branding/
    - assets/branding/web/
    - assets/branding/windows/

⚠️ No runtime asset loading logic should change.

---

## Platform Mapping

| Platform | Asset Source | Notes |
|----------|-------------|------|
| Android  | adaptive + mipmap | uses foreground/background |
| iOS      | app_icon_master | Xcode asset catalog |
| Web      | web icons | PWA + favicon |
| Windows  | .ico | runner resources |

---

## Splash Strategy

- Use native splash (platform-level)
- Use same background color across platforms
- Center splash_logo.png

No Flutter-based splash screen should replace native one.

---

## Branding Validation Checklist

- [ ] App icon consistent across platforms
- [ ] No distortion or stretching
- [ ] Proper padding in adaptive icons
- [ ] Splash centered and clean
- [ ] Dark mode consistency verified
- [ ] No placeholder assets remaining

---

## Output of Phase 6.5

At the end of this subphase:

- All branding assets are finalized
- Asset structure is stable
- Flutter project references are correct
- Ready to proceed with platform packaging

---

## Next Phase

➡️ Phase 6.1 — Android Packaging & Play Store Readiness