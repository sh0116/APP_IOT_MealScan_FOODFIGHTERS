import 'package:flutter/material.dart';
import 'package:osam2021/components/onboarding_carousel.dart';

class OnboardingScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Intro"),
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            OnboardingCarousel(),
          ]
        )
          
      ),
    );
  }
}
