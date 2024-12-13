import 'package:flutter/material.dart';
import 'package:netword_logger/main.dart';

void showGlobalSnackBar(
  String message,
) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
