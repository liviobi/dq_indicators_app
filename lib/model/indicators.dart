import 'dart:html';

import 'package:flutter/foundation.dart';

import 'indicator.dart';

class Indicators extends ChangeNotifier {
  final List<Indicator> _indicators = [
    Indicator(
        "Parsable sentences", "parsable", "This is a sample description", ""),
    Indicator(
        "Fit of training data", "fit", "This is a sample description", ""),
    Indicator("Lexical diversity", "lexical_diversity",
        "This is a sample description", ""),
    Indicator("Correctly spelled", "spelling_mistakes",
        "This is a sample description", ""),
    Indicator("Present in dictionary", "present_in_dictionary",
        "This is a sample description", ""),
    Indicator("Recognized by POS", "recognized_by_pos",
        "This is a sample description", ""),
    Indicator("Average Sentence Length", "avg_sentence_len",
        "This is a sample description", ""),
    Indicator("Readability (CLI)", "readability_cli",
        "This is a sample description", ""),
    Indicator("Readability (ARI)", "readability_ari",
        "This is a sample description", ""),
    Indicator("Confidence Tokenizer", "confidence_tokenizer",
        "This is a sample description", ""),
    Indicator(
        "Confidence POS", "confidence_pos", "This is a sample description", ""),
    Indicator(
        "Confidence NER", "confidence_ner", "This is a sample description", ""),
    Indicator("Confidence Chunker", "confidence_chunker",
        "This is a sample description", ""),
  ];

  List<Indicator> get indicators {
    //can also simply do return _indicators
    return [..._indicators];
  }

  List get indicatorsName {
    final result = [];
    for (Indicator indicator in _indicators) {
      result.add(indicator.name);
    }
    return result;
  }

  void clear() {
    for (Indicator indicator in _indicators) {
      indicator.value = "";
    }
  }
}
