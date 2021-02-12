import 'package:flutter/material.dart';

@immutable
class AppColors {
  final primary = const Color(0xFF00A1E0);
  final semiPrimary = const Color(0xFFC0E0F0);
  final support = const Color(0xFF505560);
  final semiSupport = const Color(0xFF9095A0);
  final lightSupport = const Color(0xFFEAEFF5);
  final pointYellow = const Color(0xFFF5B510);
  final pointRed = const Color(0xFFF51525);
  final base = const Color(0xFFFFFFFF);
  final transparent = const Color(0x00FFFFFF);
  final fontPalette = const [
    const Color(0xFF000510),
    const Color(0xFF202530),
    const Color(0xFF505560),
    const Color(0xFFA0A5B0),
    const Color(0xFFFFFFFF)
  ];

  const AppColors();
}