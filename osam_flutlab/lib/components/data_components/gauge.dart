import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class Gauge extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                thickness: 0.1
            ),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 180,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '50%',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            ],
            pointers: const <GaugePointer>[
              RangePointer(
                  value: 50,
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
}