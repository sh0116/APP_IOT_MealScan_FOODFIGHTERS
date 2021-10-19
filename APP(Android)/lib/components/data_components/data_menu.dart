import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

class DataMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cards = [
      menuCard('조식', '팽이버섯계란국\n돼지고기 양배추볶음\n오이무침', '팽이버섯 계란국, 오이무침',
          Color(0xfff9eefc)),
      menuCard('중식', '자장면\n탕수육\n단무지무침\n배추김치', '배추김치', Color(0xfff2f3f5)),
      menuCard('석식', '부대찌개\n꽈리고추멸치볶음\n계란찜', '꽈리고추멸치볶음', Color(0xffedf9f5))
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
        autoplay: true,
        itemCount: cards.length,
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget menuCard(String mealType, String menu, String disliked, Color c) {
    return Container(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$mealType', style: TextStyle(color: Colors.black45)),
            SizedBox(height: 15),
            Text('$menu'),
            SizedBox(height: 25),
            // Text('\u{1F616} 적게 받으세요: $disliked',
            //     style:
            //         TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: c,
        )
    );
  }
}
