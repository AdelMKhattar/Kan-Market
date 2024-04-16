import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:kan_market/Screens/chooseaera/choosearea.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/Screens/Register/Login.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoadingScreen extends StatefulWidget {
  
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
 

int d;
class _LoadingScreenState extends State<LoadingScreen> {
  @override
    /*check() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('username');
      print(username);
      if(username==null)
      d=1;
      else d=0;
          
      
    }*/
  
  Widget build(BuildContext context) {
    //heck();
    return 
    (
      seconds:3,
      backgroundColor: Colors.white12,
      image: Image.asset("assets/images/logo.png",),
      photoSize: 150.0,
      loaderColor: Colors.pink[300],
    
      
      navigateAfterSeconds:Login()

    );
 
    }
  }
