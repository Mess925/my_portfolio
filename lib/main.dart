// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: r'mess_t@terminal:~$',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: false, // Use classic Material Design
        scaffoldBackgroundColor: const Color(0xFF000000),
        textTheme: GoogleFonts.courierPrimeTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: const Color(0xFF00FF00),
            displayColor: const Color(0xFF00FF00),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00FF00),
          secondary: const Color(0xFF00CC00),
          surface: const Color(0xFF001100),
          background: const Color(0xFF000000),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
