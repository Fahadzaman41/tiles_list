import 'package:flutter/material.dart';

/// Centralized application color palette following Material Design 3 guidelines.
/// Professional navy blue theme with modern slate and accent tones.
class AppColors {
  // Primary Palette (Navy Blue theme)
  static const Color primary = Color(0xFF1E293B);       // Slate Navy
  static const Color primaryDark = Color(0xFF0F172A);   // Deep Navy
  static const Color primaryLight = Color(0xFF334155);  // Light Navy
  static const Color accent = Color(0xFF2563EB);        // Royal Accent Blue
  static const Color accentLight = Color(0xFFDBEAFE);   // Soft Blue Tint

  // Background Tones
  static const Color background = Color(0xFFF8FAFC);   // Cool Off-White/Light Slate
  static const Color surface = Color(0xFFFFFFFF);      // Pure White Surface
  static const Color cardBg = Color(0xFFFFFFFF);       // White Card

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);  // Very Dark Slate
  static const Color textSecondary = Color(0xFF64748B);// Muted Slate Gray
  static const Color textLight = Color(0xFF94A3B8);    // Soft Gray

  // Status Colors
  static const Color success = Color(0xFF10B981);      // Emerald Green
  static const Color error = Color(0xFFEF4444);        // Bright Red
  static const Color warning = Color(0xFFF59E0B);      // Amber
  static const Color info = Color(0xFF3B82F6);         // Info Blue

  // UI Element Colors
  static const Color border = Color(0xFFE2E8F0);       // Subtle Border
  static const Color inputFill = Color(0xFFF1F5F9);    // Input Box Fill
  static const Color shadow = Color(0x0F000000);       // Soft Elevation Shadow
  static const Color divider = Color(0xFFE2E8F0);      // Divider Line

  // Department Badge Colors
  static const Color deptSE = Color(0xFF2563EB);       // Software Eng (Blue)
  static const Color deptCS = Color(0xFF7C3AED);       // Computer Sci (Purple)
  static const Color deptIT = Color(0xFF059669);       // Info Tech (Teal)
}
