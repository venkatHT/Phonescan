import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Providers/documentProvider.dart';

class BHome extends StatefulWidget {
  @override
  _BHomeState createState() => _BHomeState();
}

class _BHomeState extends State<BHome> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DocumentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: ThemeData.dark().canvasColor),
            textSelectionColor: Colors.blueGrey,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: ThemeData.dark().canvasColor)),
        home: Home(),
      ),
    );
  }
}
