import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Uygulama genelinde kullanılan yazı tipleri ve text style'ları
/// Tüm yazı tipleri Poppins olarak standardize edilmiştir
class AppTextStyles {
  // Ana yazı tipi - Poppins
  static String get fontFamily => 'Poppins';

  // Büyük başlıklar
  static TextStyle get heading1 => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle get heading2 => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get heading3 => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get heading4 => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle get heading5 => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle get heading6 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  // Gövde metinleri
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  // Buton yazı tipleri
  static TextStyle get buttonLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get buttonMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // Label yazı tipleri
  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get labelMedium => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get labelSmall => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitleGrey,
  );

  // Alt yazılar
  static TextStyle get subtitle1 => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
  );

  static TextStyle get subtitle2 => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  // Caption yazı tipi
  static TextStyle get caption => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  // Overline yazı tipi
  static TextStyle get overline => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
    letterSpacing: 1.5,
  );

  // Logo yazı tipi
  static TextStyle get logo => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    letterSpacing: 0.5,
  );

  static TextStyle get logoSmall => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    letterSpacing: 0.5,
  );

  // Özel text style'lar
  static TextStyle get cardTitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle get cardSubtitle => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
  );

  static TextStyle get listItemTitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle get listItemSubtitle => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  // Form elemanları
  static TextStyle get inputText => GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get inputLabel => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextGrey,
  );

  static TextStyle get inputHint => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  // Error yazı tipi
  static TextStyle get error => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.red,
  );

  // Link yazı tipi
  static TextStyle get link => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlue,
    decoration: TextDecoration.underline,
  );

  // İstatistik yazı tipleri
  static TextStyle get statisticNumber => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryBlue,
  );

  static TextStyle get statisticLabel => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  // Tab yazı tipleri
  static TextStyle get tabActive => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
  );

  static TextStyle get tabInactive => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleGrey,
  );

  static TextStyle get titleMedium => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static TextStyle get buttonText => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}

/// Text style'ları customize etmek için extension
extension AppTextStyleExtensions on TextStyle {
  /// Rengi değiştir
  TextStyle withColor(Color color) => copyWith(color: color);

  /// Font ağırlığını değiştir
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);

  /// Font boyutunu değiştir
  TextStyle withSize(double size) => copyWith(fontSize: size);

  /// Opacity ekle
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withValues(alpha: opacity));

  /// Decoration ekle
  TextStyle withDecoration(TextDecoration decoration) =>
      copyWith(decoration: decoration);

  /// Letter spacing ekle
  TextStyle withLetterSpacing(double spacing) =>
      copyWith(letterSpacing: spacing);

  /// Line height ekle
  TextStyle withHeight(double height) => copyWith(height: height);
}
