import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../api.dart';
import '../model/indicator.dart';

class IndicatorCard extends StatefulWidget {
  final Indicator indicator;
  final String filename;

  const IndicatorCard(this.indicator, this.filename, {Key? key})
      : super(key: key);

  @override
  State<IndicatorCard> createState() => _IndicatorCardState();
}

class _IndicatorCardState extends State<IndicatorCard> {
  SfRadialGauge _buildDistanceTrackerExample() {
    var isCardView = true;
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.8,
            maximum: 100,
            axisLineStyle: const AxisLineStyle(
                cornerStyle: CornerStyle.startCurve, thickness: 5),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(widget.indicator.value + "%",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 30)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      )
                    ],
                  )),
              GaugeAnnotation(
                angle: 124,
                positionFactor: 1.1,
                widget: Text('0', style: TextStyle(fontSize: 14)),
              ),
              GaugeAnnotation(
                angle: 54,
                positionFactor: 1.1,
                widget: Text('100',
                    style: TextStyle(fontSize: isCardView ? 12 : 14)),
              ),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: double.parse(widget.indicator.value),
                width: 18,
                pointerOffset: -6,
                cornerStyle: CornerStyle.bothCurve,
                color: Color(0xFFF67280),
                gradient: const SweepGradient(
                    colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
                    stops: <double>[0.25, 0.75]),
              ),
              MarkerPointer(
                value: double.parse(widget.indicator.value),
                color: Colors.white,
                markerType: MarkerType.circle,
              ),
            ]),
      ],
    );
  }

  updateIndicatorCard() async {
    final jsonData =
        await getIndicator(widget.filename, widget.indicator.searchKey);
    if (jsonData["indicator"] != "processing") {
      setState(() {
        widget.indicator.value = jsonData["indicator"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      print("sending request for ${widget.indicator.name}");
      updateIndicatorCard();
      if (widget.indicator.value != "") {
        timer.cancel();
        print("result recieved, cancelling timer for ${widget.indicator.name}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            child: widget.indicator.value == ""
                ? CircularProgressIndicator()
                : _buildDistanceTrackerExample(),
          ),
          Text("${widget.indicator.name} value: "),
          Text(widget.indicator.value)
        ],
      ),
    );
  }
}
