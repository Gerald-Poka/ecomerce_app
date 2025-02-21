// import 'package:ecommerce_app/auth/login_screen.dart';
// import 'package:ecommerce_app/auth/login_screen.dart';
// import 'package:ecommerce_app/auth/login_screen.dart';
// import 'package:ecommerce_app/second/seller_home_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
// Import HomeScreen

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a splash screen for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      // After 5 seconds, navigate to the home screen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check the system theme (light or dark)
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white, // Set background based on theme
      body: Center(
        child: Image.asset(
          isDarkMode ? 'assets/images/logo2.png' : 'assets/images/logo.png', // Load different logo
        ),
      ),
    );
  }
}
