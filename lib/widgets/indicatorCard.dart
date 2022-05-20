import 'package:flutter/material.dart';

import '../model/indicator.dart';

class IndicatorCardStateless extends StatelessWidget {
  final Indicator indicator;
  const IndicatorCardStateless(this.indicator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(indicator.name), Text(indicator.value)],
    );
  }
}
