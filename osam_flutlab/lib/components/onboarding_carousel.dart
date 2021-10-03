import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var onboardingPagesList = [
      Container(child: Text("똑똑하고 재밌는 \n 잔반 줄이기"),),
      _buildPages(Icon(FontAwesomeIcons.camera), "식사 후 밀스캔 하드웨어로 식판을 찍어주세요. 저희가 스캔하겠습니다."),
      _buildPages(Icon(CupertinoIcons.sportscourt), "챌린지에 참여하여 각종 포상 획득하세요."),
      _buildPages(Icon(Icons.food_bank), "잔반 데이터 분석으로 식습관 파악하세요.")
    ];
    return Swiper(
      itemBuilder: (context, index) {
        return Container(child: onboardingPagesList[index]);
      },
      itemCount: 4,
      autoplay: true,
      pagination: new SwiperPagination(),


    );
  }

  Widget _buildPages(Icon icon, String text) {
    return Column(
      children: [
        icon,
        Text(text),
      ]
    );
  }
}
