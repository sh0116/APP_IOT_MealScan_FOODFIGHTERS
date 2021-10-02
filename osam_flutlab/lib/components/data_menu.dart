import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


class DataMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SwiperController controller = new SwiperController();
    var cards = [menuCard('조식', '팽이버섯계란국, 돼지고기 양배추볶음, 오이무침', '팽이버섯 계란국, 오이무침', Color(0xfff9eefc)), 
    menuCard('중식', '자장면, 탕수육, 단무지무침, 배추김치', '배추김치', Color(0xfff2f3f5)), menuCard('석식', '부대찌개, 꽈리고추멸치볶음, 계란찜', '꽈리고추멸치볶음', Color(0xffedf9f5))];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        viewportFraction: 0.8,
        //autoplay: true,
        itemWidth: 400,
        scale: 0.9,
        itemCount: 3, 
        curve: Curves.ease,
        itemBuilder: (context, index) {
          return Container(child: cards[index]);
        },
        loop: true,
        pagination: new SwiperPagination()
      ),
    );
  }

  Widget menuCard(String mealType, String menu, String disliked, Color c) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$mealType'),
          SizedBox(height: 7),
          Text('$menu',style: TextStyle(fontFamily: 'SpoqaHanSansNeo')),
          Text('\u{1F616} 적게 드세요: $disliked', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: c,
      )
    );
  }
}