import 'package:flutter/material.dart';

void showDemoFeedback(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
