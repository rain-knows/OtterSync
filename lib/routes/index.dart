import 'package:flutter/material.dart';
import 'package:ottersync/pages/Main/index.dart';

final ThemeData _appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0E5E6F),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F7F8),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF132026),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 72,
    indicatorColor: const Color(0xFFD7EEF2),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
);

Widget getRootWidget() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: _appTheme,
    home: const MainPage(),
  );
}
