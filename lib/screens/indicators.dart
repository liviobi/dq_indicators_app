import 'package:flutter/material.dart';

import '../api.dart';

class IndicatorsScreen extends StatefulWidget {
  const IndicatorsScreen({Key? key}) : super(key: key);
  static const routeName = '/indicators';

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  @override
  Widget build(BuildContext context) {
    final filename = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(title: Text("Dashboard for $filename")),
        body: Center(
          child: Column(
            children: [
              Text("here the cards"),
              TextButton(
                  onPressed: () =>
                      getIndicator(filename, "confidence_tokenizer"),
                  child: Text("push"))
            ],
          ),
        ));
  }
}
