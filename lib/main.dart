import 'package:flutter/material.dart';
import 'package:marchand/auth/login_screen.dart';
import 'package:marchand/auth/registrer_screen.dart';
import 'package:marchand/onboarding/onboarding_screen.dart';
import 'package:marchand/screen/acceuil_screen.dart';
import 'package:marchand/navigation/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marchand Sénégal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1A237E)),
        ),
      ),
     home:  OnboardingScreen(),
      //home:  RegisterScreen(),
      //home:  LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
