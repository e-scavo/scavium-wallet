import 'package:flutter/material.dart';
import 'package:scavium_wallet/app/theme/tokens/scavo_colors.dart';

/// Theme-specific color sets built from the SCAVIUM semantic token contract.
class ScavoThemeColors {
  final Brightness brightness;
  final Color canvas;
  final Color layer;
  final Color surfaceBase;
  final Color surfaceRaised;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color actionPrimary;
  final Color actionSecondary;
  final Color actionDisabled;
  final Color textOnAction;
  final Color danger;
  final Color warning;
  final Color success;
  final Color info;
  final Color focusRing;

  const ScavoThemeColors({
    required this.brightness,
    required this.canvas,
    required this.layer,
    required this.surfaceBase,
    required this.surfaceRaised,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.actionPrimary,
    required this.actionSecondary,
    required this.actionDisabled,
    required this.textOnAction,
    required this.danger,
    required this.warning,
    required this.success,
    required this.info,
    required this.focusRing,
  });

  static const dark = ScavoThemeColors(
    brightness: Brightness.dark,
    canvas: ScavoColors.backgroundCanvas,
    layer: ScavoColors.backgroundLayer,
    surfaceBase: ScavoColors.surfaceBase,
    surfaceRaised: ScavoColors.surfaceRaised,
    border: ScavoColors.borderDefault,
    divider: ScavoColors.dividerDefault,
    textPrimary: ScavoColors.textPrimary,
    textSecondary: ScavoColors.textSecondary,
    textDisabled: ScavoColors.textDisabled,
    actionPrimary: ScavoColors.actionPrimary,
    actionSecondary: ScavoColors.actionSecondary,
    actionDisabled: ScavoColors.actionDisabled,
    textOnAction: ScavoColors.textOnAction,
    danger: ScavoColors.semanticDanger,
    warning: ScavoColors.semanticWarning,
    success: ScavoColors.semanticSuccess,
    info: ScavoColors.semanticInfo,
    focusRing: ScavoColors.focusRing,
  );

  static const light = ScavoThemeColors(
    brightness: Brightness.light,
    canvas: Color(0xFFF5F7FB),
    layer: Color(0xFFEAF0FA),
    surfaceBase: Colors.white,
    surfaceRaised: Color(0xFFF0F4FA),
    border: Color(0xFFD6DFEE),
    divider: Color(0xFFD6DFEE),
    textPrimary: Color(0xFF0A0D14),
    textSecondary: Color(0xFF44516D),
    textDisabled: Color(0xFF8792A8),
    actionPrimary: ScavoColors.brandPrimary,
    actionSecondary: Color(0xFF0AAE7A),
    actionDisabled: Color(0xFFB6C2D6),
    textOnAction: ScavoColors.brandOnPrimary,
    danger: Color(0xFFD7374F),
    warning: Color(0xFF9A6A00),
    success: Color(0xFF087A55),
    info: ScavoColors.brandPrimary,
    focusRing: ScavoColors.brandPrimary,
  );
}
