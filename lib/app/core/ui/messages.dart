import 'package:flutter/material.dart';
import 'package:routime_app/app/core/ui/constants.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) {
    _showMessage(message, Colors.red);
  }

  void showInfo(String message) {
    _showMessage(message, ColorsConstants.purple);
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
