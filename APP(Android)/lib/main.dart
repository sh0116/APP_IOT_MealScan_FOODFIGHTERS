import 'package:osam2021/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:osam2021/screens/onboarding_screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:osam2021/notifiers.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool signed_in = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Notifiers>(
      create: (_) => Notifiers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: signed_in ? MainScreen() : OnboardingScreen(notifyParent: update), //MainScreen() is the original
      ),
    );
  }

  update() {
    setState(() {
      signed_in = true;
    });
  }
}
