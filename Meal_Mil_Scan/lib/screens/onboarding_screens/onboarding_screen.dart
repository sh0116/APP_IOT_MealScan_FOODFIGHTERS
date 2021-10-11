import 'package:flutter/material.dart';
import 'package:osam2021/components/onboarding_components/onboarding_carousel.dart';
import 'package:osam2021/screens/onboarding_screens/onboarding_questions.dart';

class OnboardingScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        )
      ),      
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text("잔반 줄이기, \이제 즐기세요.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              OnboardingCarousel(),
              Container(height: 100),
              MaterialButton(
                color: Colors.black,
                child: 
                  Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
                    return OnboardingQuestions();
                  }));
                },
                height: 60,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                ),
                minWidth: double.infinity,                
              )
            ]
          ),
        )  
      ),
    );
  }
  
}
