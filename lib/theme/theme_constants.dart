import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light theme configuration
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6F61EF),
    secondary: Color(0xFF39D2C0),
    tertiary: Color(0xFFEE8B60),
    surface: Color(0xFFF1F4F8),
    background: Color(0xFFFDFDFD),
    error: Color(0xFFFF5963),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF15161E),
    onTertiary: Color(0xFF15161E),
    onSurface: Color(0xFF15161E),
    onBackground: Color(0xFF15161E),
    onError: Color(0xFFFFFFFF),
    outline: Color(0xFFB0BEC5),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF15161E),
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF15161E),
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF15161E),
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF15161E),
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF15161E),
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF15161E),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF15161E),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF57636C),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF15161E),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF57636C),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF1F4F8),
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFB0BEC5), width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFF6F61EF), width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFFF5963), width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFFF5963), width: 2.0),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF57636C),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF57636C),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6F61EF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      textStyle: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6F61EF),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF6F61EF),
      side: const BorderSide(color: Color(0xFF6F61EF), width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF15161E),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF15161E),
    ),
  ),
);

// Dark theme configuration
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6F61EF),
    secondary: Color(0xFF39D2C0),
    tertiary: Color(0xFFEE8B60),
    surface: Color(0xFF1D2428),
    background: Color(0xFF111417),
    error: Color(0xFFFF5963),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onTertiary: Color(0xFFFFFFFF),
    onSurface: Color(0xFFE5E7EB),
    onBackground: Color(0xFFE5E7EB),
    onError: Color(0xFFFFFFFF),
    outline: Color(0xFF374047),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFE5E7EB),
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFE5E7EB),
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFE5E7EB),
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFE5E7EB),
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFE5E7EB),
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFE5E7EB),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFE5E7EB),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFADB5BD),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE5E7EB),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFADB5BD),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1D2428),
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFF374047), width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFF374047), width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFF6F61EF), width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFFF5963), width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Color(0xFFFF5963), width: 2.0),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFADB5BD),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFADB5BD),
    ),
  ),
  cardTheme: CardTheme(
    color: const Color(0xFF1D2428),
    elevation: 3.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6F61EF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      textStyle: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6F61EF),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF6F61EF),
      side: const BorderSide(color: Color(0xFF6F61EF), width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF111417),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFE5E7EB),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFE5E7EB),
    ),
  ),
);