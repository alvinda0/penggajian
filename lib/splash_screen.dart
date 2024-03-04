import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penggajian/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds then navigate to the login page
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0), // Ubah nilai sesuai kebutuhan
              child: Image.asset(
                'assets/images/icon.png',
                width: 350, // Menetapkan lebar gambar
                height: 50, // Menetapkan tinggi gambar
              ),
            ),
          ),
        ],
      ),
    );
  }
}
