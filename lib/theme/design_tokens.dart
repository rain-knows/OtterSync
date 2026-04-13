import 'package:flutter/material.dart';

class AppPalette {
  final Color brand;
  final Color brandAccent;
  final Color brandHover;
  final Color brandSoft;
  final Color canvas;
  final Color panel;
  final Color surface;
  final Color surfaceSecondary;
  final Color title;
  final Color text;
  final Color subtitle;
  final Color muted;
  final Color success;
  final Color warning;
  final Color borderSubtle;
  final Color border;
  final Color borderStrong;
  final Color overlay;

  const AppPalette({
    required this.brand,
    required this.brandAccent,
    required this.brandHover,
    required this.brandSoft,
    required this.canvas,
    required this.panel,
    required this.surface,
    required this.surfaceSecondary,
    required this.title,
    required this.text,
    required this.subtitle,
    required this.muted,
    required this.success,
    required this.warning,
    required this.borderSubtle,
    required this.border,
    required this.borderStrong,
    required this.overlay,
  });
}

abstract final class AppColors {
  static const dark = AppPalette(
    brand: Color(0xFF5E6AD2),
    brandAccent: Color(0xFF7170FF),
    brandHover: Color(0xFF828FFF),
    brandSoft: Color(0x1A7170FF),
    canvas: Color(0xFF08090A),
    panel: Color(0xFF0F1011),
    surface: Color(0xFF191A1B),
    surfaceSecondary: Color(0xFF28282C),
    title: Color(0xFFF7F8F8),
    text: Color(0xFFD0D6E0),
    subtitle: Color(0xFF8A8F98),
    muted: Color(0xFF62666D),
    success: Color(0xFF10B981),
    warning: Color(0xFFE86B6B),
    borderSubtle: Color(0x0DFFFFFF),
    border: Color(0x14FFFFFF),
    borderStrong: Color(0x1FFFFFFF),
    overlay: Color(0xD9000000),
  );

  static const light = AppPalette(
    brand: Color(0xFF5E6AD2),
    brandAccent: Color(0xFF5B63E6),
    brandHover: Color(0xFF4F57D6),
    brandSoft: Color(0x145E6AD2),
    canvas: Color(0xFFF6F7FB),
    panel: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFE9ECF4),
    title: Color(0xFF16181D),
    text: Color(0xFF3E4653),
    subtitle: Color(0xFF697180),
    muted: Color(0xFF8D94A3),
    success: Color(0xFF1F9D63),
    warning: Color(0xFFD95C5C),
    borderSubtle: Color(0x0D0F172A),
    border: Color(0x14111827),
    borderStrong: Color(0x22111827),
    overlay: Color(0xA6000000),
  );
}

abstract final class AppThemePalette {
  static AppPalette of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
  }
}

abstract final class AppSpace {
  static const pagePadding = EdgeInsets.fromLTRB(20, 16, 20, 24);
  static const sectionGap = SizedBox(height: 20);
  static const cardRadius = 22.0;
  static const pillRadius = 999.0;
}

abstract final class AppDecorations {
  static BoxDecoration panel({
    required AppPalette palette,
    BorderRadius? radius,
    Color? color,
    Border? border,
  }) {
    return BoxDecoration(
      color: color ?? palette.surface.withValues(alpha: 0.9),
      borderRadius: radius ?? BorderRadius.circular(AppSpace.cardRadius),
      border: border ?? Border.all(color: palette.border),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ],
    );
  }
}
