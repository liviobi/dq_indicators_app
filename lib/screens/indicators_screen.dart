import 'package:flutter/material.dart';
import 'package:frontend/model/selecte_file_model.dart';
import 'package:provider/provider.dart';

import '../model/indicators.dart';
import '../widgets/indicatorCard_stf.dart';

class IndicatorsScreen extends StatefulWidget {
  const IndicatorsScreen({Key? key}) : super(key: key);
  static const routeName = '/indicators';

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedFileProvider = Provider.of<SelectedFileModel>(context);
    final filename = selectedFileProvider.filename;

    final db = Provider.of<Indicators>(context);
    List checkedIndicators = db.checkedIndicators;
    if (checkedIndicators.isEmpty) {
      checkedIndicators = db.indicators;
    }
    return Scaffold(
        appBar: AppBar(title: Text("Dashboard for $filename")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(children: [
                  ...checkedIndicators.map((indicator) {
                    return IndicatorCard(indicator, filename);
                  }).toList()
                ]),
              ),
            ],
          ),
        ));
  }
}
