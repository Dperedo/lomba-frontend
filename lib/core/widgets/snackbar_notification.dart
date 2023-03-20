import 'package:flutter/material.dart';

import '../constants.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarNotify(
    BuildContext context, String message, IconData? icon) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const VerticalDivider(),
          Text(message)
        ],
      ),
      duration: const Duration(milliseconds: snackBarConfig.snackbarDuration),
    ),
  );
}
