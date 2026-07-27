import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // ── Base palette (elevated cosmic dark) ───────────────────────────────────
  static const Color bg = Color(0xFF07050F);
  static const Color surface = Color(0xFF110D1F);
  static const Color surfaceAlt = Color(0xFF1C1730);
  static const Color surfaceGlass = Color(0x18FFFFFF);
  static const Color border = Color(0xFF2A2050);
  static const Color borderGlow = Color(0x33BF5AF2);
  static const Color accent = Color(0xFFBF5AF2);
  static const Color accentSoft = Color(0x22BF5AF2);
  static const Color accentGlow = Color(0x55BF5AF2);
  static const Color gold = Color(0xFFFFD700);
  static const Color teal = Color(0xFF64D2FF);

  // ── Text colors ───────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF0ECFF);
  static const Color textSecondary = Color(0xFFB0A8D0);
  static const Color textMuted = Color(0xFF6B6490);

  // ── Per-philosophy gradient pairs ─────────────────────────────────────────
  static const Map<String, List<Color>> _gradients = {
    'Stoicism': [Color(0xFFD4AF37), Color(0xFF8B5E00)],
    'Existentialism': [Color(0xFF9B8EC4), Color(0xFF2C3E50)],
    'Nihilism': [Color(0xFF4A5568), Color(0xFF1A1A2E)],
    'Absurdism': [accent, Color(0xFF5E5CE6)],
    'Humanism': [Color(0xFF4A90D9), Color(0xFF2ECC71)],
    'Fatalism': [Color(0xFF8E44AD), Color(0xFF2C3E50)],
    'Individualism': [Color(0xFFE91E63), Color(0xFF9C27B0)],
    'Collectivism': [Color(0xFF2ECC71), Color(0xFF1ABC9C)],
    'Minimalism': [Color(0xFFA5D6A7), Color(0xFF52B788)],
    'Hedonism': [Color(0xFFFFC107), Color(0xFFFF5722)],
    'Asceticism': [Color(0xFF8D6E63), Color(0xFF5D4037)],
    'Pragmatism': [Color(0xFF80CBC4), Color(0xFF00695C)],
    'Optimism': [Color(0xFFFFEB3B), Color(0xFFFF9800)],
    'Pessimism': [Color(0xFF546E7A), Color(0xFF263238)],
    'Cynicism': [Color(0xFF66BB6A), Color(0xFF2E7D32)],
    'Romanticism': [Color(0xFFE91E63), Color(0xFF9C27B0)],
    'Realism': [Color(0xFF78909C), Color(0xFF37474F)],
    'Buddhism': [Color(0xFFFFA726), Color(0xFFF57C00)],
    'Taoism': [Color(0xFF66BB6A), Color(0xFF1B5E20)],
    'Confucianism': [Color(0xFFEF5350), Color(0xFFB71C1C)],
    'Virtue Ethics': [Color(0xFFFFB74D), Color(0xFFE65100)],
    'Logotherapy': [Color(0xFFCE93D8), Color(0xFF6A1B9A)],
    'Epicureanism': [Color(0xFFA5D6A7), Color(0xFF1B5E20)],
    'Wabi-sabi': [Color(0xFFBCAAA4), Color(0xFF4E342E)],
    'Ikigai': [Color(0xFFF48FB1), Color(0xFFAD1457)],
    'Rationalism': [Color(0xFF7E57C2), Color(0xFF311B92)],
    'Phenomenology': [Color(0xFF4FC3F7), Color(0xFF01579B)],
    'Idealism': [Color(0xFF80DEEA), Color(0xFF00838F)],
    'Stoic Zen': [Color(0xFF80DEEA), Color(0xFF26C6DA)],
  };

  static List<Color> gradientFor(String philosophy) {
    return _gradients[philosophy] ?? const [accent, Color(0xFF5E5CE6)];
  }
}
