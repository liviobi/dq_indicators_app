import 'package:flutter/foundation.dart';

import 'indicator.dart';

class Indicators extends ChangeNotifier {
  final List<Indicator> _indicators = [
    Indicator(
        "Parsable sentences",
        "parsable",
        "Percentage of sentecens that can be parsed by an automatic syntax parser",
        ""),
    //Indicator("Fit of training data", "fit", "This is a sample description", ""),
    Indicator("Lexical diversity", "lexical_diversity",
        "The number of unique words over the total number of words", ""),
    Indicator("Correctly spelled", "spelling_mistakes",
        "Percentage of words correctly spelled", ""),
    Indicator("Present in dictionary", "present_in_dictionary",
        "Percentage of words present in a dictionary", ""),
    Indicator("Recognized by POS", "recognized_by_pos",
        "Percentage of words recognized by a part of speech tagger", ""),
    Indicator(
        "Average Sentence Length",
        "avg_sentence_len",
        "How close is the average sentence lenght to the optimal value for average sentence length",
        ""),
    Indicator(
        "Readability (CLI)",
        "readability_cli",
        "How close is the result of Coleman-Liau index to a it's optimal value",
        ""),
    Indicator(
        "Readability (ARI)",
        "readability_ari",
        "How close is the result of automatic readability index to a it's optimal value",
        ""),
    Indicator("Confidence Tokenizer", "confidence_tokenizer",
        "Average confidence of tokenizer classification", ""),
    Indicator("Confidence POS", "confidence_pos",
        "Average confidence of the part of speech tagger classification", ""),
    Indicator(
        "Confidence NER",
        "confidence_ner",
        "Average confidence of the named entity recognitioner classification",
        ""),
    Indicator("Confidence Chunker", "confidence_chunker",
        "Average confidence of the chunker classification", ""),
    Indicator("Acronyms", "acronyms",
        "The percentage of words that aren't acronyms", ""),
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

  List get checkedNames {
    final result = [];
    for (Indicator indicator in _indicators) {
      if (indicator.checked == true) {
        result.add(indicator.name);
      }
    }
    return result;
  }

  get checkedIndicators {
    var result = [];
    for (Indicator indicator in _indicators) {
      if (checkedNames.contains(indicator.name)) {
        result.add(indicator);
      }
    }
    return result;
  }

  Indicator getIndicatorByName(name) {
    for (Indicator indicator in _indicators) {
      if (indicator.name == name) {
        return indicator;
      }
    }
    throw Exception();
  }

  void toggleIndicator(name) {
    Indicator indicator = getIndicatorByName(name);
    if (indicator.checked == true) {
      indicator.checked = false;
    } else {
      indicator.checked = true;
    }
    notifyListeners();
  }

  void clear() {
    for (Indicator indicator in _indicators) {
      indicator.value = "";
    }
  }
}
