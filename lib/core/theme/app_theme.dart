import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        inversePrimary: Color(0xFFEAB308),
        inverseSurface: Color(0xFF2E3135),
        onErrorContainer: Color(0xFF410002),
        onInverseSurface: Color(0xFFEFF0F7),
        onPrimaryContainer: Color(0xFF1E0E5F),
        onSecondary: Color(0xFFFFFFFF),
        onSecondaryContainer: Color(0xFF1E0E5F),
        onSurface: Color(0xFF191C20),
        onSurfaceVariant: Color(0xFF43474E),
        onTertiary: Color(0xFFFFFFFF),
        onTertiaryContainer: Color(0xFF251431),
        outline: Color(0xFF73777F),
        outlineVariant: Color(0xFFC3C7CF),
        primary: Color(0xFF4A2A91),
        primaryContainer: Color(0xFFE9DDFF),
        scrim: Color(0xFF000000),
        secondary: Color(0xFFEAB308),
        secondaryContainer: Color(0xFFFFF8E1),
        shadow: Color(0xFF000000),
        surface: Color(0xFFF8F9FF),
        surfaceContainerHighest: Color(0xFFE1E2E8),
        surfaceTint: Color(0xFF4A2A91),
        tertiary: Color(0xFF6B5778),
        tertiaryContainer: Color(0xFFF2DAFF),
      ),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ),
        displayMedium: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
        ),
        displaySmall: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
        ),
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.27,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ),
        labelSmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ),
      ),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        inversePrimary: Color(0xFF4A2A91),
        inverseSurface: Color(0xFFE1E2E8),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        onInverseSurface: Color(0xFF2E3135),
        onPrimary: Color(0xFF1E0E5F),
        onPrimaryContainer: Color(0xFFE9DDFF),
        onSecondary: Color(0xFF3F2E00),
        onSecondaryContainer: Color(0xFFFFF8E1),
        onSurface: Color(0xFFE1E2E8),
        onSurfaceVariant: Color(0xFFC3C7CF),
        onTertiary: Color(0xFF3B2948),
        onTertiaryContainer: Color(0xFFF2DAFF),
        outline: Color(0xFF8D9199),
        outlineVariant: Color(0xFF43474E),
        primary: Color(0xFFCFBCFF),
        primaryContainer: Color(0xFF4A2A91),
        scrim: Color(0xFF000000),
        secondary: Color(0xFFF7DE7E),
        secondaryContainer: Color(0xFFB78C00),
        shadow: Color(0xFF000000),
        surface: Color(0xFF191C20),
        surfaceContainerHighest: Color(0xFF43474E),
        surfaceTint: Color(0xFFCFBCFF),
        tertiary: Color(0xFFD6BEE4),
        tertiaryContainer: Color(0xFF523F5F),
      ),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
          color: Color(0xFFE1E2E8),
        ),
        displayMedium: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.16,
          color: Color(0xFFE1E2E8),
        ),
        displaySmall: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.22,
          color: Color(0xFFE1E2E8),
        ),
        headlineLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.25,
          color: Color(0xFFE1E2E8),
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.29,
          color: Color(0xFFE1E2E8),
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.33,
          color: Color(0xFFE1E2E8),
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          height: 1.27,
          color: Color(0xFFE1E2E8),
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
          color: Color(0xFFE1E2E8),
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
          color: Color(0xFFE1E2E8),
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
          color: Color(0xFFE1E2E8),
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
          color: Color(0xFFE1E2E8),
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
          color: Color(0xFFE1E2E8),
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
          color: Color(0xFFE1E2E8),
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
          color: Color(0xFFE1E2E8),
        ),
        labelSmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
          color: Color(0xFFE1E2E8),
        ),
      ),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
