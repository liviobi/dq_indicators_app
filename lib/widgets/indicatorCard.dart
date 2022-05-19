import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:frontend/model/indicators.dart';
import 'package:provider/provider.dart';

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
