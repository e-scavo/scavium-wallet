# Phase 9 — Application Identity, Versioning, and Visual Theme Maturity

## Overview

Phase 9 opens after the complete closure of Phase 8.6.

Phase 8 matured the wallet product surface, account model, asset and portfolio model, transaction/activity behavior, signing surfaces, navigation shell, reliability posture, diagnostics safety, and release/distribution automation. Phase 9 intentionally does not reopen those runtime feature domains.

The purpose of Phase 9 is to consolidate the visible identity layer of SCAVIUM Wallet: the version displayed by the application, the consistency of version propagation through release tooling, and the visual theme system that frames every product surface.

This phase is required because the real Phase 8.6-completed codebase still contains three product-identity gaps:

- the Settings/About surface displays a hardcoded application version (`Version 0.4.0`) instead of resolving it from project/build metadata;
- `pubspec.yaml` remains the version and MSIX metadata owner, while release tooling already performs MSIX synchronization, but the behavior needs a dedicated hardening/validation pass so operators can distinguish normal `--no-version-bump` behavior from an actual synchronization defect;
- the application currently runs with a forced dark theme (`ThemeMode.dark`) and a single dark theme surface, while the visual result is not yet normalized into a reusable SCAVIUM token system or paired light/dark theme contract.

Phase 9 therefore moves the project from release/distribution maturity into application identity and visual-system maturity.

---

## Initial Context

The project state used to open this phase is the Phase 8.6-completed ZIP.

Relevant real baseline observations:

- `pubspec.yaml` declares the application version as `version: 0.2.2+1`.
- `pubspec.yaml` declares `msix_config.msix_version: 0.2.2.1`.
- `lib/features/settings/presentation/settings_screen.dart` still displays `Version 0.4.0` as static copy.
- `lib/app/app.dart` forces `themeMode: ThemeMode.dark`.
- `lib/app/theme/app_theme.dart` exposes `AppTheme.darkTheme` only.
- `tool/build.dart` contains version parsing, build-number bumping, and MSIX synchronization logic, including `syncMsixVersion(...)`.

These observations define Phase 9 as a product identity, build-version consistency, and visual theme maturity phase.

---

## Problem Statement

SCAVIUM Wallet has reached a mature feature and release baseline, but several identity-level details remain too static or visually under-normalized for a production-grade product:

1. Runtime application version is not derived from the same version source used by packaging and release tooling.
2. Build/version behavior is not yet documented and validated as an explicit product identity contract after Phase 8.6.
3. The visual system is currently dark-only and too tightly coupled to saturated runtime colors instead of a normalized design token system.
4. The Settings surface does not yet act as the user-facing identity/control surface for version and appearance.

If left unresolved, these gaps create visible inconsistencies between what is built, what is distributed, and what the user sees inside the wallet.

---

## Phase Goals

Phase 9 must:

- remove hardcoded runtime application version display;
- introduce a runtime version surface that resolves from reliable application metadata;
- harden and document build-version/MSIX synchronization expectations;
- define a SCAVIUM design token system before changing broad visual behavior;
- implement coherent light and dark themes based on those tokens;
- support runtime theme-mode selection and persistence;
- align Settings/About so application identity and appearance controls are visible, explicit, and stable.

---

## Non-Goals

Phase 9 must not introduce:

- new blockchain transaction behavior;
- new account, asset, activity, signing, backup, restore, diagnostics, or routing features beyond what is required to expose version/theme controls;
- WalletConnect or dApp connectivity;
- telemetry or analytics;
- automatic Play Store upload;
- automatic Microsoft Store submission;
- runtime update delivery;
- remote theme configuration;
- white-labeling implementation;
- a full visual redesign disconnected from the existing SCAVIUM brand.

---

## Implementation Rules

Phase 9 must preserve the established project execution model:

- the ZIP / working tree is the only source of truth;
- documentation is trunk documentation and must be updated incrementally, not rewritten from scratch;
- code implementation subphases must remain bounded and testable;
- `.agent/*` generation/execution may be used only when explicitly requested for code-only execution;
- documentation closure must not include `.agent/*` artifacts in the deliverable unless the requested task is agent generation itself;
- runtime behavior changes must be covered by focused tests where practical;
- build tooling changes must be validated without relying on generated artifacts as source-controlled evidence.

---

## SCAVIUM Design Token System Proposal

The SCAVIUM Design Token System is the visual foundation for Phase 9. It must be defined before broad theme changes so that light and dark themes share the same language instead of diverging into separate ad-hoc palettes.

### Token Families

Phase 9 should introduce or normalize the following token families:

#### Brand Tokens

Brand tokens represent SCAVIUM identity and should remain recognizable across light and dark modes.

- `brandPrimary` — primary SCAVIUM color used for main actions and high-signal highlights.
- `brandSecondary` — secondary identity color used for supportive emphasis.
- `brandAccent` — accent color used sparingly for confirmations, selected states, or controlled glow-like emphasis.

#### Background Tokens

Background tokens define visual depth without relying on excessive saturation.

- `backgroundBase` — application canvas.
- `backgroundLayer` — first elevated visual layer.
- `backgroundLayerSoft` — softer layer for grouped controls and quiet cards.
- `backgroundOverlay` — modal/dialog/sheet layer.

#### Surface Tokens

Surface tokens define component hierarchy.

- `surfacePrimary` — default cards and panels.
- `surfaceSecondary` — nested surfaces.
- `surfaceMuted` — low-emphasis informational blocks.
- `surfaceInteractive` — tappable/hoverable surface state.

#### Border and Divider Tokens

Borders should be visible enough to separate surfaces without creating visual noise.

- `borderSubtle` — default card/section border.
- `borderFocus` — focused input or selected control border.
- `dividerSubtle` — separators inside dense surfaces.

#### Text Tokens

Text tokens must keep contrast and hierarchy stable in both themes.

- `textPrimary` — main readable text.
- `textSecondary` — supporting text.
- `textMuted` — metadata and lower-emphasis labels.
- `textOnBrand` — text over primary brand surfaces.
- `textDanger` — destructive or critical warning text.

#### Semantic Tokens

Semantic tokens must be distinct from brand tokens.

- `success` — completed/safe states.
- `warning` — caution states.
- `danger` — destructive/error states.
- `info` — neutral informative states.

#### Interaction Tokens

Interaction tokens must define visible feedback without over-saturating the base UI.

- `hover` — desktop/web hover affordance.
- `pressed` — pressed/tap feedback.
- `selected` — selected navigation/control state.
- `disabled` — disabled foreground/background pairing.
- `focusRing` — keyboard/accessibility focus indication.

#### Shape and Spacing Tokens

Shape and spacing should keep the current rounded SCAVIUM look but make it consistent.

- `radiusSmall`
- `radiusMedium`
- `radiusLarge`
- `radiusXL`
- `spacingXS`
- `spacingS`
- `spacingM`
- `spacingL`
- `spacingXL`

#### Elevation / Shadow Tokens

Elevation should remain subtle, especially in dark mode.

- `elevationNone`
- `elevationSoft`
- `elevationModal`

### Theme Strategy

Phase 9 should produce two first-class themes:

- `AppTheme.lightTheme`
- `AppTheme.darkTheme`

Both themes must be derived from the same token model. Light mode should not be a simple inversion of dark mode; it should preserve SCAVIUM identity while reducing visual weight. Dark mode should keep the existing brand direction but reduce saturation and improve surface separation.

### Visual Normalization Principles

The token system should enforce:

- fewer direct color references inside screens;
- lower saturation on background and large surfaces;
- stronger contrast only where interaction or hierarchy requires it;
- consistent card, input, navigation, dialog, and list-tile behavior;
- explicit semantic colors for danger/warning/success/info instead of reusing brand colors for meaning;
- parity between mobile and desktop/web surfaces.

### Future-Proofing

This proposal intentionally prepares the codebase for future branding or white-label capability without implementing those features in Phase 9.

The immediate goal is not customization. The immediate goal is a stable, internal SCAVIUM visual contract.

---

## Phase Structure

## 9.0 — Phase Definition & Documentation Lock

### Objective

Open Phase 9 from the real Phase 8.6-completed codebase and lock the application identity, versioning, and visual theme maturity scope.

### Scope

- Document the Phase 9 problem statement, goals, non-goals, and implementation rules.
- Record the baseline version/theme observations from the real ZIP.
- Introduce the SCAVIUM Design Token System proposal as the visual foundation for later subphases.
- Update trunk documentation only.

### State

Completed documentation-only phase-opening subphase.

### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md`
- `README.md`
- `docs/index.md`
- `docs/architecture.md`
- `docs/architecture_deep.md`
- `docs/features.md`
- `docs/ux.md`
- `docs/development.md`
- `docs/decisions.md`
- `docs/release.md`

### New Files Tentatively Creatable

- `docs/phase9_scavium_wallet.md`

### Expected Validations

- Confirm Phase 9 is represented in documentation without modifying runtime code.
- Confirm no non-existent project documents are referenced as required flow documents.
- Confirm Phase 8.6 remains closed and Phase 9 is represented as the active next phase.

### 9.0 Closure Result

Phase 9.0 is complete as a documentation-only phase definition and lock.

This closure confirms that Phase 9 has been opened from the real Phase 8.6-completed project state and that its scope is intentionally limited to application identity, versioning, visual theme maturity, Settings/About alignment, and the SCAVIUM Design Token System foundation.

No Dart code, build tooling, CI workflow, runtime wallet behavior, blockchain behavior, account model, asset model, signing flow, backup/restore behavior, diagnostics behavior, navigation contract, or release publication behavior is modified by Phase 9.0.

The documentation trunk now records Phase 9 as active, with 9.1 as the next implementation subphase.

---

## 9.1 — Runtime App Version Surface

### Objective

Remove hardcoded version display from the application and surface the real application version at runtime.

### Scope

- Replace static Settings/About version copy.
- Add an application identity/version provider or equivalent service boundary.
- Resolve version/build metadata using a Flutter-compatible package or generated build metadata approach.
- Display version consistently in the Settings/About surface.
- Add focused tests where practical.

### State

Planned implementation subphase.

The real Phase 9.0 ZIP confirms that 9.1 is not yet implemented in code. `lib/features/settings/presentation/settings_screen.dart` still renders `Version 0.4.0` as static copy, while `pubspec.yaml` owns `version: 0.2.2+1` and `msix_config.msix_version: 0.2.2.1`. The current dependency set does not include a runtime application metadata package, and there is no existing `lib/core/app_identity` or equivalent version boundary.

### Existing Files Tentatively Intervenable

- `pubspec.yaml` — add a Flutter-compatible runtime metadata dependency only if the implementation chooses package-based version resolution instead of generated metadata.
- `lib/features/settings/presentation/settings_screen.dart` — replace the hardcoded About subtitle with dynamic application version/build metadata.
- `test/settings_screen_test.dart` — extend the existing Settings widget coverage so the About section remains present and can be validated with a deterministic version source.
- `docs/phase9_scavium_wallet.md` — record the actual 9.1 implementation result and validation outcome when 9.1 is executed.
- `README.md` — update only if the runtime version surface becomes part of the visible product summary after implementation.
- `docs/index.md` — update only if the active Phase 9 ledger needs to advance from planning to completed 9.1 state.

### New Files Tentatively Creatable

- `lib/core/app_identity/app_version_info.dart` — optional value object for app name, semantic version, build number, and display label if the implementation benefits from a typed boundary.
- `lib/core/app_identity/app_version_provider.dart` — optional Riverpod provider/service owner for resolving runtime package metadata and exposing it to Settings without coupling UI directly to platform APIs.
- `test/app_version_info_test.dart` — optional focused unit test if formatting/version-label behavior is extracted from the Settings widget.

### Technical Justification

The application must not display a version that diverges from the version used to build and distribute the wallet. Runtime identity should derive from metadata, not from manually edited UI copy. A small identity boundary keeps Settings/About simple and prevents future visual or release tooling work from depending on hardcoded UI text.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Settings/About no longer contains a literal stale version string.
- Runtime display resolves the app name/version/build number from a single metadata boundary.
- Tests avoid depending on the developer machine or generated build artifacts.

### 9.1 Subphase Determination

Phase 9 already defines `9.1 — Runtime App Version Surface` as the next executable implementation subphase. Because 9.1 is small but crosses dependency metadata, application boundary, UI, and tests, it should be executed as a compact set of nested subphases rather than as one unstructured edit.

The following nested subphases are derived from the real ZIP and are intentionally limited to the runtime version surface. They do not touch build/MSIX synchronization, theme tokens, light/dark behavior, theme persistence, signing, assets, transactions, routing, backup/restore, diagnostics behavior, or release publication.

---

### 9.1.1 — Runtime Version Metadata Boundary

#### Objective

Introduce the smallest stable runtime identity boundary capable of resolving the application name, semantic version, build number, and display label from project/build metadata.

#### Scope

- Add a runtime metadata dependency only if required by the selected implementation strategy.
- Create a small app identity/version owner under the existing application/core layering.
- Keep version formatting centralized so Settings does not manually compose version strings.
- Avoid introducing release-tooling logic into runtime code.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `pubspec.yaml` — required only if the implementation uses a package such as `package_info_plus` to resolve runtime metadata across Flutter targets.
- `pubspec.lock` — updated automatically only if a dependency is added through `flutter pub get`.
- `docs/phase9_scavium_wallet.md` — record whether the implementation selected package-based metadata or generated metadata.

#### New Files Tentatively Creatable

- `lib/core/app_identity/app_version_info.dart` — typed representation of app identity metadata and display formatting.
- `lib/core/app_identity/app_version_provider.dart` — Riverpod provider/service wrapper that isolates platform/package metadata resolution from UI code.

#### Technical Justification

The real code currently has no application identity owner and no package capable of reading runtime package metadata. Introducing a narrow boundary prevents `SettingsScreen` from depending directly on platform package APIs and gives tests a stable override point.

#### Expected Validations

- Metadata boundary exposes deterministic display data.
- No Settings UI behavior is changed yet except through later subphases.
- Added dependency, if any, is limited to runtime package metadata and does not alter wallet/domain behavior.

---

### 9.1.2 — Settings/About Runtime Version Integration

#### Objective

Replace the hardcoded About version text in Settings with data from the runtime version metadata boundary.

#### Scope

- Convert the About tile from static version copy to provider-backed version display.
- Preserve the existing Settings section structure introduced during Phase 8.4.
- Keep loading/error fallback behavior quiet and product-safe.
- Avoid broad Settings redesign; appearance controls belong to later Phase 9 subphases.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `lib/features/settings/presentation/settings_screen.dart` — replace `Version 0.4.0` with runtime identity display while preserving the existing Settings sections.
- `test/settings_screen_test.dart` — keep existing Settings section assertions valid after the About tile becomes dynamic.
- `docs/phase9_scavium_wallet.md` — record the actual UI integration result.

#### New Files Tentatively Creatable

None expected by default. A small Settings-specific widget may be created only if the About row becomes complex enough to justify reuse.

#### Technical Justification

The exact inconsistency identified by Phase 9.0 lives in `SettingsScreen`: the UI says `Version 0.4.0` while `pubspec.yaml` owns `0.2.2+1`. 9.1.2 closes that visible product inconsistency without touching build tooling or theme work.

#### Expected Validations

- Settings/About still renders `SCAVIUM Wallet`.
- The stale literal `Version 0.4.0` is removed from runtime UI code.
- The displayed version derives from the metadata boundary.
- Settings layout remains responsive and sectioned as before.

---

### 9.1.3 — Runtime Version Surface Test Coverage

#### Objective

Add focused tests that prove the About surface remains stable while the version value is dynamic and overrideable.

#### Scope

- Extend existing Settings widget tests or add a focused identity/version test.
- Prefer provider overrides or metadata mocks over environment-dependent assertions.
- Validate the display label format without relying on local release artifacts.

#### State

New planned nested implementation subphase.

#### Existing Files Tentatively Intervenable

- `test/settings_screen_test.dart` — extend the existing Settings coverage to assert dynamic About behavior under a deterministic test value.
- `pubspec.yaml` — only if test support requires a metadata package already introduced by 9.1.1.
- `docs/phase9_scavium_wallet.md` — record the executed validation strategy.

#### New Files Tentatively Creatable

- `test/app_version_info_test.dart` — optional unit test for display-label formatting if formatting is extracted into `AppVersionInfo`.

#### Technical Justification

Runtime metadata can vary by platform, test runner, and generated build state. Tests must validate the application contract through a controlled boundary, not by assuming a particular machine-local package result.

#### Expected Validations

- `fvm flutter test test/settings_screen_test.dart`
- Optional focused unit test for version label formatting if a value object is introduced.
- Existing Settings section test intent remains intact.

---

### 9.1.close — Runtime App Version Surface Closure

#### Objective

Close 9.1 by confirming that the stale hardcoded version was removed, runtime metadata is surfaced through a controlled boundary, and documentation reflects the implemented state.

#### Scope

- Record actual files intervened by 9.1 implementation.
- Record validation commands and outcomes.
- Confirm 9.2 remains the next Phase 9 implementation subphase after 9.1 closure.
- Update trunk documentation only from the real implemented state.

#### State

Planned documentation closure for 9.1 after implementation.

#### Existing Files Tentatively Intervenable

- `docs/phase9_scavium_wallet.md` — document 9.1 execution result, files touched, validation outcome, and next subphase.
- `docs/index.md` — advance the Phase 9 status only if 9.1 has actually been implemented and validated.
- `README.md` — update only if the product summary should explicitly mention dynamic runtime version identity after implementation.
- `docs/release.md` — update only if the runtime version surface materially affects release/operator guidance; otherwise leave release tooling documentation for 9.2.

#### New Files Tentatively Creatable

None expected.

#### Technical Justification

9.1 closes a visible application identity gap but does not harden build/MSIX synchronization. The closure must therefore avoid claiming 9.2 outcomes while clearly advancing Phase 9 from runtime version display into build-version hardening.

#### Expected Validations

- Confirm no `.agent/*` artifacts are part of documentation delivery.
- Confirm no theme, build-tool, release workflow, wallet runtime, signing, asset, backup, restore, diagnostics, or routing behavior is documented as changed by 9.1 unless the real implementation proves otherwise.
- Confirm the next implementation subphase remains `9.2 — Build Version & MSIX Synchronization Hardening`.

---

## 9.2 — Build Version & MSIX Synchronization Hardening

### Objective

Clarify and harden the relationship between `pubspec.yaml`, build-number mutation, and `msix_config.msix_version`.

### Scope

- Validate the current `tool/build.dart` version/MSIX synchronization behavior.
- Ensure `--no-version-bump` behavior is explicit and not confused with a sync failure.
- Add focused tests or script-level validation if the project structure supports it.
- Update release/development documentation with exact command expectations.

### Existing Files Tentatively Intervenable

- `tool/build.dart`
- `docs/release.md`
- `docs/development.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

- Build-tool tests or validation helpers only if the current project test structure can support them without adding unnecessary complexity.

### Technical Justification

Phase 8.6 matured release tooling, but Phase 9 must close the identity gap between displayed runtime version, project version source, and Windows MSIX metadata.

---

## 9.3 — Theme Token Normalization

### Objective

Introduce a normalized SCAVIUM design token layer as the foundation for coherent themes.

### Scope

- Define token ownership in the app theme layer.
- Reduce direct screen-level color coupling where necessary.
- Normalize brand, background, surface, text, semantic, border, interaction, radius, and spacing tokens.
- Preserve the existing SCAVIUM identity while reducing visual saturation.

### Existing Files Tentatively Intervenable

- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_text_styles.dart`
- `lib/app/theme/app_theme.dart`
- Screens/components only where direct color usage prevents token adoption.
- `docs/ux.md`
- `docs/architecture.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

- A dedicated token file only if the existing `app/theme` structure becomes clearer with separation.

### Technical Justification

Theme changes should not be implemented as scattered color edits. A token layer provides one controlled visual vocabulary for later light/dark parity and future brand evolution.

---

## 9.4 — Light/Dark Theme Implementation

### Objective

Implement first-class light and dark SCAVIUM themes using the normalized token system.

### Scope

- Add `AppTheme.lightTheme`.
- Refine `AppTheme.darkTheme` from token values.
- Ensure Material 3 `ColorScheme`, card, input, app bar, navigation, dialog, list, snackbar, and button behavior remain coherent.
- Validate core screens visually and through widget tests where practical.

### Existing Files Tentatively Intervenable

- `lib/app/theme/app_theme.dart`
- `lib/app/theme/app_colors.dart`
- Shared components and shell/navigation widgets if they require theme alignment.
- Relevant widget tests.

### New Files Tentatively Creatable

None expected by default unless theme token separation was introduced in 9.3.

### Technical Justification

The application currently exposes only a dark theme and forces it globally. Light/dark support should be implemented as a product-level theme contract, not as a per-screen override.

---

## 9.5 — Theme Mode Runtime Selection and Persistence

### Objective

Allow the user to select theme behavior and persist the selection locally.

### Scope

- Support `system`, `light`, and `dark` theme modes.
- Persist the selected theme mode locally.
- Apply the selected mode reactively through the app root.
- Keep the implementation local-only and privacy-preserving.

### Existing Files Tentatively Intervenable

- `lib/app/app.dart`
- `lib/app/theme/*`
- `lib/features/settings/presentation/settings_screen.dart`
- A controller/provider/repository layer for theme preference if required.
- Relevant tests.

### New Files Tentatively Creatable

- Theme preference controller/provider/repository files if no existing owner is appropriate.

### Technical Justification

Theme mode is a user-facing appearance preference. It should not be hardcoded in `MaterialApp.router`, and it should not require rebuilding or reinstalling the application.

---

## 9.6 — Settings and About UX Alignment

### Objective

Align Settings/About as the stable application identity and appearance control surface.

### Scope

- Display app name and dynamic version clearly.
- Add a theme mode selector with clear labels.
- Keep destructive actions, security/recovery actions, diagnostics, signing, and about information visually separated.
- Ensure Settings remains responsive across mobile and desktop/web.

### Existing Files Tentatively Intervenable

- `lib/features/settings/presentation/settings_screen.dart`
- Settings-specific widgets if present or introduced.
- `docs/ux.md`
- `docs/features.md`
- `docs/phase9_scavium_wallet.md`

### New Files Tentatively Creatable

None expected by default unless Settings needs a small reusable selector widget.

### Technical Justification

The Settings screen already owns secondary controls and About information after Phase 8.4. Phase 9 should extend that ownership coherently rather than creating a separate identity screen.

---

## 9.close — Application Identity, Versioning, and Visual Theme Maturity Closure

### Objective

Close Phase 9 by validating that runtime identity, build-version consistency, and visual theme maturity are implemented and documented coherently.

### Scope

- Confirm runtime version display is dynamic.
- Confirm build/MSIX version behavior is documented and validated.
- Confirm light/dark themes are token-based and visually coherent.
- Confirm theme preference selection/persistence works as intended.
- Update trunk documentation from the real implemented state.

### Expected Validations

- `fvm flutter analyze`
- `fvm flutter test`
- Build-tool validation commands relevant to version/MSIX behavior.
- Manual visual review of light/dark Settings, shell, dashboard, asset/activity surfaces, dialogs, inputs, snackbars, and danger-zone actions.

---

## Recommended Implementation Order

1. Phase 9.0 documentation lock is complete.
2. Implement 9.1 runtime version surface before changing Settings broadly.
3. Harden 9.2 build/MSIX behavior while version ownership is fresh.
4. Normalize 9.3 design tokens before adding light mode.
5. Implement 9.4 light/dark themes from tokens.
6. Implement 9.5 theme selection and persistence.
7. Polish 9.6 Settings/About UX alignment.
8. Close with 9.close documentation and validation.

---

## Risk Register

### Visual Regression Risk

Theme changes affect the entire application. Phase 9 mitigates this risk by introducing tokens first and changing surfaces incrementally.

### Over-Saturation Risk

The existing visual language can feel heavy when saturated colors are used on large surfaces. Phase 9 mitigates this by reserving strong brand colors for high-signal elements and using calmer background/surface tokens.

### Version Source Confusion Risk

Runtime display, `pubspec.yaml`, MSIX metadata, generated artifacts, and release tags can diverge if not explicitly owned. Phase 9 mitigates this by treating runtime version display and build/MSIX synchronization as adjacent subphases.

### Scope Creep Risk

Theme work can easily become a redesign. Phase 9 explicitly limits itself to identity/version/theme maturity and Settings/About alignment.

---

## Phase 9 Initial Status

Status: Active.

Phase 9 is opened as the active next phase after Phase 8.6 closure. It is not a continuation of release/distribution implementation, but it depends on the Phase 8.6 versioning and release-tooling baseline.

Phase 9.0 is complete as the phase definition and documentation lock. The next executable implementation subphase is 9.1 — Runtime App Version Surface.
