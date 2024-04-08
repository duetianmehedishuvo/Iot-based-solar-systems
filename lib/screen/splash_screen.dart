import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/screen/auth/login_screen.dart';
import 'package:women_safety/screen/dashboard/dashboard_screen.dart';
import 'package:women_safety/util/theme/app_colors.dart';
import 'package:women_safety/util/theme/text.styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/raw/solar.json'),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Welcome IoT-based Solar Systems',
              style: sfProStyle500Medium.copyWith(color: colorGreen, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
