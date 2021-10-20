//데이터 스크린의 누적 잔반클리어률을 보여주는 gauge

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final serviceNumber = '20-71209928';

class Gauge extends StatelessWidget {
  //Firebase Firestore USER_FOOD_WASTE_AVG Collection을 선언
  final CollectionReference waste = FirebaseFirestore.instance.collection('USER_FOOD_WASTE_AVG');
  @override
  Widget build(BuildContext context) {
    //Future Builder를 활용해 평균 잔반량 정보를 불러오고 불러와졌을 때 SfRadialGauge를 빌드함
    return FutureBuilder<DocumentSnapshot>(
      future: waste.doc(serviceNumber).get(),
      builder: 
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  minimum: 0,
                  maximum: 100,
                  radiusFactor: 0.8,
                  axisLineStyle: const AxisLineStyle(
                      cornerStyle: CornerStyle.bothCurve,
                      thicknessUnit: GaugeSizeUnit.factor,
                      thickness: 0.1),
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        angle: 180,
                        widget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                data['WASTE_AVG'],
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  ],
                  pointers: <GaugePointer>[
                    RangePointer(
                        value: double.parse(data['WASTE_AVG'].split('%')[0]),
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationDuration: 4500,
                        animationType: AnimationType.ease,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(
                            colors: <Color>[Color(0xFFFCE38A), Color(0xFFF38181)],
                            stops: <double>[0.25, 0.75]),
                        color: Color(0xFF00A8B5),
                        width: 0.15),
                  ]),
            ],
          );
        }
        return Text("loading");
        },
      );
    } 
  }
