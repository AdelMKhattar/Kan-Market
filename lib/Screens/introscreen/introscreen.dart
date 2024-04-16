import 'package:flutter/material.dart';


class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar:AppBar(
            title: Text('Welcome'),backgroundColor: Colors.amber,
      ),
      body: Container(
        color:Colors.white38
      )
    );
  }
}