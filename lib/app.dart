import 'package:flutter/material.dart';
import 'package:kan_market/Screens/loadingscreen/loadingscree.dart';
import 'styles.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          body1: bodyText,
          title: titleText,
        )

      ),
    );
  }
}
