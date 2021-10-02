import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class DataMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cards = [
      menuCard('조식', '팽이버섯계란국, 돼지고기 양배추볶음, 오이무침', '팽이버섯 계란국, 오이무침',
          Color(0xfff9eefc)),
      menuCard('중식', '자장면, 탕수육, 단무지무침, 배추김치', '배추김치', Color(0xfff2f3f5)),
      menuCard('석식', '부대찌개, 꽈리고추멸치볶음, 계란찜', '꽈리고추멸치볶음', Color(0xffedf9f5))
    ];

    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (context, index) {
          return Container(child: cards[index]);
        },
        viewportFraction: 0.8,
        scale: 0.9,
        fade: 1.0,
        curve: Curves.ease,
        itemCount: cards.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  Widget menuCard(String mealType, String menu, String disliked, Color c) {
    return Container(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$mealType'),
            SizedBox(height: 7),
            Text('$menu', style: TextStyle(fontFamily: 'SpoqaHanSansNeo')),
            Text('\u{1F616} 적게 드세요: $disliked',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: c,
        ));
  }
}
