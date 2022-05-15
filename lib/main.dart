import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/indicators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Data Quality Indicators For Text'),
      initialRoute: '/',
      routes: {
        IndicatorsScreen.routeName: (ctx) => const IndicatorsScreen(),
      },
    );
  }
}
