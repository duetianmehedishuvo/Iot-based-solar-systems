import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/screen/auth/login_screen.dart';
import 'package:women_safety/util/helper.dart';
import 'package:women_safety/util/size.util.dart';
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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/raw/solar.json'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'SolOptima',
                    style: sfProStyle500Medium.copyWith(color: colorGreen, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/nasa.png',
                fit: BoxFit.scaleDown, height: 50, width: screenWeight()),
          ),
          spaceHeight10
        ],
      ),
    );
  }
}
