import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/pages/Main/index.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

final ThemeData _appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brand,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.canvas,
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.title,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpace.cardRadius),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 72,
    indicatorColor: AppColors.brandSoft,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
);

final AppState _appState = AppState();
final GoRouter _rootRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainPage(),
    ),
  ],
);

Widget getRootWidget() {
  return AppStateScope(
    notifier: _appState,
    child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: _appTheme,
      routerConfig: _rootRouter,
    ),
  );
}
