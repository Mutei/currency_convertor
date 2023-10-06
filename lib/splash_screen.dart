import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'currency_convertor.dart';
import 'constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Show splash screen initially
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<ConnectivityResult>
      connectivitySubscription; // Add this line

  @override
  void initState() {
    super.initState();
    _initConnectivity(); // Initialize connectivity
    _checkConnectivityAndNavigate();
  }

  @override
  void dispose() {
    // Cancel the connectivity subscription when the widget is disposed
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Handle connectivity changes here
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        // Internet connectivity available, navigate to CurrencyConvertor screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const CurrencyConvertor(),
          ),
        );
      }
    });
  }

  Future<void> _checkConnectivityAndNavigate() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // Check if internet connectivity is already available
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // Internet connectivity available, navigate to CurrencyConvertor screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const CurrencyConvertor(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your splash screen content here
            Hero(
              tag:
                  'uniqueTag', // Make sure this tag matches the one in SplashScreen
              child: Image.asset(
                'images/logo.png',
              ),
            ), // Replace with your image
            const SizedBox(height: 16),
            const CircularProgressIndicator(), // Loading indicator if needed
          ],
        ),
      ),
    );
  }
}
