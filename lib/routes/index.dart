import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/pages/AI/index.dart';
import 'package:ottersync/pages/Dashboard/index.dart';
import 'package:ottersync/pages/Home/index.dart';
import 'package:ottersync/pages/Main/index.dart';
import 'package:ottersync/pages/My/index.dart';
import 'package:ottersync/pages/Workspace/index.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/state/theme_controller.dart';
import 'package:ottersync/theme/design_tokens.dart';

ThemeData _buildAppTheme(AppPalette palette, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: palette.brand,
          brightness: brightness,
        ).copyWith(
          primary: palette.brand,
          secondary: palette.brandAccent,
          surface: palette.surface,
        ),
    scaffoldBackgroundColor: palette.canvas,
    fontFamily: 'Inter',
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: palette.title,
    ),
    dividerColor: palette.border,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        color: palette.title,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.7,
        height: 1.05,
      ),
      titleLarge: TextStyle(
        color: palette.title,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.3,
      ),
      titleMedium: TextStyle(
        color: palette.title,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      titleSmall: TextStyle(
        color: palette.title,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: palette.text, fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(color: palette.text, fontSize: 15, height: 1.6),
      bodySmall: TextStyle(
        color: palette.subtitle,
        fontSize: 13,
        height: 1.5,
        letterSpacing: -0.13,
      ),
      labelLarge: TextStyle(color: palette.title, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
        color: palette.text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: palette.surface.withValues(alpha: 0.88),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpace.cardRadius),
        side: BorderSide(color: palette.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: palette.surface.withValues(alpha: 0.5),
      hintStyle: TextStyle(color: palette.muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.brandAccent),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: palette.surface,
      selectedColor: palette.brandSoft,
      disabledColor: palette.surface,
      side: BorderSide(color: palette.border),
      labelStyle: TextStyle(color: palette.text, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: palette.brand,
        foregroundColor: Colors.white,
        disabledBackgroundColor: palette.surfaceSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.text,
        side: BorderSide(color: palette.borderStrong),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: palette.brandAccent,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: palette.text,
      textColor: palette.title,
      subtitleTextStyle: TextStyle(color: palette.subtitle, height: 1.5),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: palette.brandAccent,
      linearTrackColor: palette.surfaceSecondary,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      backgroundColor: palette.panel.withValues(alpha: 0.96),
      indicatorColor: palette.brandSoft,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(fontWeight: FontWeight.w600, color: palette.text),
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? palette.title : palette.subtitle,
        );
      }),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: palette.brandAccent,
      selectionColor: palette.brandSoft,
    ),
    splashColor: palette.brandSoft,
    highlightColor: Colors.transparent,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.panel,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: palette.panel,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpace.cardRadius),
        side: BorderSide(color: palette.border),
      ),
    ),
  );
}

final AppState _appState = AppState();
final ThemeController _themeController = ThemeController();
final GoRouter _rootRouter = GoRouter(
  initialLocation: '/projects',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/projects'),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/projects',
              name: 'projects',
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/workspace',
              name: 'workspace',
              builder: (context, state) => const WorkspaceView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/ai',
              name: 'ai',
              builder: (context, state) => const AIView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              builder: (context, state) => const DashboardView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my',
              name: 'my',
              builder: (context, state) => const MyView(),
            ),
          ],
        ),
      ],
    ),
  ],
);

Widget getRootWidget() {
  return AppStateScope(
    notifier: _appState,
    child: ThemeControllerScope(
      notifier: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: _buildAppTheme(AppColors.light, Brightness.light),
            darkTheme: _buildAppTheme(AppColors.dark, Brightness.dark),
            themeMode: _themeController.themeMode,
            routerConfig: _rootRouter,
          );
        },
      ),
    ),
  );
}
