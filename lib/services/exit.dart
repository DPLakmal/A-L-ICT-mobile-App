import 'dart:io';
import 'package:almcq/localization/language_controller.dart';
import 'package:almcq/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(BuildContext context) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.exit_to_app_rounded,
                color: AppTheme.primaryColor),
            const SizedBox(width: 10),
            Text(context.tr('exit_title')),
          ],
        ),
        content: Text(
          context.tr('exit_desc'),
          style: const TextStyle(color: AppTheme.lightTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.tr('stay')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
              exit(0);
            },
            child: Text(context.tr('exit')),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
