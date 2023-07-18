import 'view/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        backgroundColor: bgColor2,
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: bgColor1,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.notoSans(
            fontSize: 35,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
          headlineMedium: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          headlineSmall: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
          bodyLarge: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
          bodyMedium: GoogleFonts.notoSans(
            color: const Color(0xFF898D9E),
            fontSize: 14,
            letterSpacing: 1.2,
          ),
          bodySmall: GoogleFonts.notoSans(
            color: const Color(0xFF898D9E),
            fontSize: 12,
            letterSpacing: 1.2,
          ),
          labelMedium: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          labelSmall: GoogleFonts.notoSans(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
