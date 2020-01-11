import 'package:awesome_hotel/providers/hotels_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/my_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => Hotel(),
      child: MaterialApp(
        title: 'Awesome Hotel',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            buttonColor: Colors.lightGreen),
        darkTheme:
            ThemeData(primarySwatch: Colors.green, brightness: Brightness.dark),
        home: MyHomePage(title: 'Awesome Hotel'),
      ),
    );
  }
}
