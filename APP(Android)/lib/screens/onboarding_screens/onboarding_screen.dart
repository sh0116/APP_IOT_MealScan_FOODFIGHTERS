//온보딩 task의 첫 화면. 가입화면으로 이어짐
import 'package:flutter/material.dart';
import 'package:osam2021/components/onboarding_components/onboarding_carousel.dart';
import 'package:osam2021/screens/onboarding_screens/onboarding_questions.dart';

class OnboardingScreen extends StatefulWidget {
  final Function() notifyParent; 
  const OnboardingScreen({required this.notifyParent});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,    
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingCarousel(),
              Container(height: 60),
              MaterialButton(
                color: Colors.black,
                child: 
                  Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
                    return OnboardingQuestions(notifyParent2: triggerSignIn);
                  }));
                },
                height: 60,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(50),
                ),
                minWidth: double.infinity,                
              ),
            ]
          ),
        )  
      ),
    );
  }

  triggerSignIn() {
    widget.notifyParent();
  }
}
