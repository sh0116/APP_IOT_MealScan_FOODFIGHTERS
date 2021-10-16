/// 유저의 잔반 데이터 분석 후 잔반 클리어률, 저번 주 일별 잔반 클리어률, 선호/비선호 메뉴를 보여주는 데이터 스크린.
import 'package:flutter/material.dart';
import 'package:osam2021/components/data_components/leftover_barchart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/components/data_components/data_menu.dart';
import 'package:osam2021/components/data_components/pie_chart.dart';
import 'package:osam2021/components/data_components/gauge.dart';

class DataScreen extends StatefulWidget {
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("나의 잔반", style: TextStyle(fontSize: 20)),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.sync, size: 18),
              onPressed: () {
                setState((){});
              },
            ),
            SizedBox(width: 16),
          ],
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ListView(
            children: [
              SizedBox(height: 30),
              Row(children: [
                Text(
                  "식단 추천",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              DataMenu(),
              SizedBox(height: 50),
              Row(children: [
                Text(
                  "누적 잔반 클리어률",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]), 
              Gauge(),              
              Row(children: [
                Text(
                  "일별 잔반 클리어률",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              LeftoverBarchart(),
              SizedBox(height: 50),
              Row(children: [
                Text(
                  "저번 달 비선호 메뉴",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(height: 30),
              LeftoverPieChart()
            ],
          ),
        )); //scaffold
  }
}
