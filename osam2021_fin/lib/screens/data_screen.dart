import 'package:flutter/material.dart';
import 'package:osam2021/components/leftover_barchart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/assets/colors.dart';

class DataScreen extends StatelessWidget {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("나의 잔반"),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.bell),
              onPressed: () {},
            ),
            SizedBox(width: 16),
          ],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(children: [
                Text(
                  "식단 추천",
                  style: TextStyle(fontSize: 20, color: Color(0xFF414160), fontWeight: FontWeight.w700), //TextStyle
                ),
                Expanded(child: Container()),
                Text(
                  "오늘의 식단 및 추천 보기",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF414160),
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward, size: 20, color: Colors.black)
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Next workout",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                        SizedBox(height: 5),
                        Text("Legs Toning",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                        SizedBox(height: 5),
                        Text("and Glutes Workout",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                        SizedBox(height: 25),
                        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Row(children: [
                            Icon(Icons.timer, size: 20, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text("60 min",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                          ]),
                          Expanded(child: Container()),
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), boxShadow: [
                                BoxShadow(color: Color(0xff0f17ad), blurRadius: 10, offset: Offset(4, 8))
                              ]),
                              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60))
                        ]),
                      ])),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff0f17ad).withOpacity(0.8),
                        Color(0xFF6985e8).withOpacity(0.9),
                      ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(offset: Offset(5, 10), blurRadius: 20, color: Color(0xFF6985e8).withOpacity(0.2))
                      ])),
              SizedBox(height: 30),
              LeftoverBarchart(),
              SizedBox(height: 30),
            ],
          ),
        )); //scaffold
  }
}
