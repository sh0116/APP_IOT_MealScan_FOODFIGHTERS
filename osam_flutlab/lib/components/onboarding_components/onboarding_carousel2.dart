import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingCarousel2 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var onboardingPagesList = [
      _buildPages("밀스캔은 식판 스캔으로 시작합니다.\n식사 후 밀스캔 하드웨어로 식판을 찍어주세요."),
      _buildPages("잔반 챌린지와 함께 잔반도 줄이고,\n각종 포상도 획득하세요."),
      _buildPages("데이터 분석으로 식습관을 파악하세요.\n그리고 다음 식사에 반영하세요.")
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
        ), 
        child: Swiper(
          scrollDirection: Axis.vertical,
          autoplay: true,
          itemBuilder: (context, index) {
            return Container(child: onboardingPagesList[index]);
          },
          itemCount: 3,
          duration: 700,
        ),
      ),
    );
  }

  Widget _buildPages(String text) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontSize: 16, color: Colors.grey.shade300), textAlign: TextAlign.left),
      ]
    );
  }
}
