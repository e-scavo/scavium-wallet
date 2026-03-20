import 'package:flutter/material.dart';

abstract final class AppSnackbar {
  static void showInfo(BuildContext context, String message) {
    _show(context, message);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message);
  }

  static void _show(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
