import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/indicator.dart';
import '../model/indicators.dart';
import '../widgets/indicatorCard_stf.dart';

class IndicatorsScreen extends StatefulWidget {
  IndicatorsScreen({Key? key}) : super(key: key);
  static const routeName = '/indicators';

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO re enable
    List<dynamic> args =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final filename = args[0] as String;
    final selectedIndicatorsNames = args[1] as List<dynamic>;

    print(selectedIndicatorsNames);

    //const filename = "prose.txt";

    final List<Indicator> indicators =
        Provider.of<Indicators>(context).indicators;

    return Scaffold(
        appBar: AppBar(title: Text("Dashboard for $filename")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(children: [
                ...selectedIndicatorsNames.map((indicator) {
                  return Text(indicator);
                }).toList()
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(children: [
                ...indicators.map((indicator) {
                  return IndicatorCard(indicator, filename);
                }).toList()
              ]),
            ),
          ],
        ));
  }
}
