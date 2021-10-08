import 'package:flutter/material.dart';
import 'package:osam2021/components/data_components/leftover_barchart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osam2021/components/data_components/data_menu.dart';
import 'package:osam2021/components/data_components/pie_chart.dart';
import 'package:osam2021/components/data_components/gauge.dart';

class DataScreen extends StatelessWidget {
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("나의 잔반", style: TextStyle(fontSize: 20)),
          actions: [
            IconButton(
              icon: Icon(FontAwesomeIcons.bell),
              onPressed: () {},
            ),
            SizedBox(width: 16),
          ],
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ListView(
            children: [
              Row(children: [
                
              ]),
              Gauge(),
              Row(children: [
                Text(
                  "식단 추천",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              DataMenu(),
              SizedBox(height: 30),
              Row(children: [
                Text(
                  "일별 평균 잔반량",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              LeftoverBarchart(),
              SizedBox(height: 30),
              Row(children: [
                Text(
                  "저번 달 비선호 메뉴",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700), //TextStyle
                ),
              ]),
              SizedBox(height: 20),
              LeftoverPieChart()
            ],
          ),
        )); //scaffold
  }
}
