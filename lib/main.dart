import 'package:flutter/material.dart';
import 'package:frontend/model/indicators.dart';
import 'package:frontend/model/selecte_file_model.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';
import 'screens/indicators_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SelectedFileModel(),
        child: ChangeNotifierProvider(
            create: (_) => Indicators(),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const MyHomePage(title: 'Data Quality Indicators For Text'),
              initialRoute: '/',
              routes: {
                IndicatorsScreen.routeName: (ctx) => IndicatorsScreen(),
              },
            )));
  }
}
