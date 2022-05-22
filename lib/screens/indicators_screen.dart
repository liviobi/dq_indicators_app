import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/indicator.dart';
import '../model/indicators.dart';
import '../widgets/indicatorCard_stf.dart';

class IndicatorsScreen extends StatefulWidget {
  IndicatorsScreen({Key? key}) : super(key: key);
  static const routeName = '/indicators';

  var indicatorsTemplate = {
    //"Confidence": {
    //  "searchKeys": [
    //    {"searchKey": "confidence_tokenizer", "name": "Confidence of Tokenizer", "value":null},
    //    {"searchKey": "confidence_pos", "name": "POS", "value":null},
    //    {"searchKey": "confidence_ner", "name": "NER", "value":null},
    //    {"searchKey": "confidence_chunker", "name": "Chunker", "value":null},
    //  ],
    //  "description": "This is a sample description"
    //},
    "Parsable sentences": {
      "searchKeys": [
        {"searchKey": "parsable", "name": "Parsable sentences", "value": null},
      ],
      "description": "This is a sample description"
    },
    "Fit of training data": {
      "searchKeys": [
        {"searchKey": "fit", "name": "Fit of training data", "value": null},
      ],
      "description": "This is a sample description"
    },
  };

  //indicatorsTemplate = {
  //  "spelling_mistakes": None,
  //  "avg_sentence_len": None,
  //  "perc_lowercase": None,
  //  "perc_uppercase": None,
  //  "lexical_diversity": None,
  //  "unknown_words": None,
  //  "acronyms": None, }

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO re enable
    //final filename = ModalRoute.of(context)!.settings.arguments as String;
    const filename = "prose.txt";
    final List<Indicator> indicators =
        Provider.of<Indicators>(context).indicators;

    return Scaffold(
        appBar: AppBar(title: Text("Dashboard for $filename")),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(children: [
            ...indicators.map((indicator) {
              return IndicatorCard(indicator, filename);
            }).toList()
          ]),
        ));
  }
}
