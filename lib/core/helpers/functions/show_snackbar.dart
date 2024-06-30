import 'package:flutter/material.dart';
import 'package:email_auth_firebase_app/core/utilities/app_routes.dart';

showSnackbar(String message, {bool error = false}) {
  if (message.contains('Unauthenticated')) return;
  closeSnackbar();
  ScaffoldMessenger.of(AppNavigator.context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: error ? Colors.red : Colors.green,
    ),
  );
}

closeSnackbar() {
  ScaffoldMessenger.of(AppNavigator.context).clearSnackBars();
}
