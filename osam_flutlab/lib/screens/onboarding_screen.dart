import 'package:flutter/material.dart';
import 'package:osam2021/components/onboarding_components/onboarding_carousel.dart';

class OnboardingScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Intro", style: TextStyle(fontSize: 20)),
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            OnboardingCarousel(),
            Container(height: 100),
            MaterialButton(
              color: Colors.black,
              child: 
                Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
              onPressed: () {},
              height: 60,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
              minWidth: double.infinity,                
            )
          ]
        )  
      ),
    );
  }
  
}
