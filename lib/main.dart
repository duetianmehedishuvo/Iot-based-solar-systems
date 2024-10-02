import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/home_provider.dart';
import 'package:women_safety/screen/splash_screen.dart';
import 'package:women_safety/util/helper.dart';

import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCWj6Wz2D1Ad0JZS4GtrSRbDVSs2b88gaU",
      appId: "1:454936401333:android:42b67af514bc3c970e35fc",
      messagingSenderId: "454936401333",
      projectId: "shuvo-shop-test",
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolOptima',
      navigatorKey: Helper.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const SplashScreen(),
    );
  }
}
