import 'package:flutter/material.dart';

class SnackBarGenerator {
  static SnackBar getNotificationMessage(String message) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
