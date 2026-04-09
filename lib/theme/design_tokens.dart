import 'package:flutter/material.dart';

abstract final class AppColors {
  static const brand = Color(0xFF0E5E6F);
  static const brandSoft = Color(0xFFD7EEF2);
  static const canvas = Color(0xFFF4F7F8);
  static const title = Color(0xFF132026);
  static const subtitle = Color(0xFF6B7B83);
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFE86B6B);
}

abstract final class AppSpace {
  static const pagePadding = EdgeInsets.fromLTRB(20, 16, 20, 24);
  static const sectionGap = SizedBox(height: 20);
  static const cardRadius = 24.0;
}
