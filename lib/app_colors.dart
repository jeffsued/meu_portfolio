import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds and surfaces
  static const background = Color(0xFF050A14);
  static const surface = Color(0xFF0A1220);
  static const card = Color(0xFF0E1A2D);
  static const cardSecondary = Color(0xFF132238);
  static const cardHover = Color(0xFF1A2E4A);

  // Borders
  static const border = Color(0xFF1C2E4D);
  static const borderLight = Color(0xFF2A4470);
  static const borderGlow = Color(0xFF3B82F6);

  // Highlights
  static const primary = Color(0xFF3B82F6);
  static const primaryHover = Color(0xFF60A5FA);
  static const cyan = Color(0xFF60A5FA);
  static const emerald = Color(0xFF3B82F6);
  static const accent = Color(0xFF2563EB);
  static const accentGlow = Color(0x333B82F6);

  // Text
  static const textPrimary = Color(0xFFF1F5F9);
  static const textSecondary = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);

  // Status and technology tags
  static const success = Color(0xFF10B981);
  static const tagBg = Color(0xFF0B1B36);
  static const tagBorder = Color(0xFF1E3A6B);
  static const tagText = Color(0xFF60A5FA);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}