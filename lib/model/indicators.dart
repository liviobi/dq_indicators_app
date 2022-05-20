import 'package:flutter/foundation.dart';

import 'indicator.dart';

class Indicators extends ChangeNotifier {
  final List<Indicator> _indicators = [
    Indicator(
        "Parsable sentences", "parsable", "This is a sample description", ""),
    Indicator(
        "Fit of training data", "fit", "This is a sample description", ""),
  ];

  List<Indicator> get indicators {
    //can also simply do return _series
    return [..._indicators];
  }

  void clear() {
    for (Indicator indicator in _indicators) {
      indicator.value = "";
    }
  }
}
