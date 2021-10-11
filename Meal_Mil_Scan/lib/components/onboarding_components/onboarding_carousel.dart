import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingCarousel extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var onboardingPagesList = [
      Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text("잔반 줄이기, \n이제 즐기세요.", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
          ]
        )
      ),
      _buildPages(Icon(FontAwesomeIcons.camera, size: 140, color: Colors.black), "밀스캔은 식판 스캔으로 시작합니다.\n식사 후 밀스캔 하드웨어로 식판을 찍어주세요."),
      _buildPages(Icon(Icons.sports_mma, size: 140, color: Colors.black), "잔반 챌린지와 함께 잔반도 줄이고,\n각종 포상도 획득하세요."),
      _buildPages(Icon(Icons.food_bank, size: 140, color: Colors.black), "데이터 분석으로 식습관을 파악하세요.\n그리고 다음 식사에 반영하세요.")
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
        ), 
        child: Swiper(
          //autoplay: true,
          itemBuilder: (context, index) {
            return Container(child: onboardingPagesList[index]);
          },
          itemCount: 4,
          duration: 700,
          pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: new DotSwiperPaginationBuilder(
            color: Colors.grey, activeColor: Colors.blueGrey),
          ),
          control: new SwiperControl()
        ),
      ),
    );
  }

  Widget _buildPages(Icon icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        icon,
        Text(text, style: TextStyle(fontSize: 20), textAlign: TextAlign.left),
      ]
    );
  }
}
