import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/Screens/about.dart';
import 'package:kan_market/Models/user.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:kan_market/Screens/items/ordersPage.dart';
import 'package:kan_market/globals.dart'as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kan_market/Screens/Register/Login.dart';
class MyDrawer extends StatefulWidget {

  @override
  _MyDrawerState createState() => _MyDrawerState();
}


class _MyDrawerState extends State<MyDrawer> {
  @override

  Widget build(BuildContext context) {
   
   return Drawer(
     
 
  child:ListView(

    padding: EdgeInsets.only(top:50),
    children: <Widget>[
     ListTile(
       leading: Icon(Icons.account_circle,size: 50,color: Colors.orange[500],),
       title: Text(globals.username),
       subtitle:Text(globals.firstname),
        

      ),
    SizedBox(height:20),
    ListTile(
        title: Text('Home'),
        leading: Icon(CupertinoIcons.home,size: 30,),
        onTap: () {
           Navigator.push(context,MaterialPageRoute(builder: (context)=>ChooseCategory()));

        
        },
      ),
      SizedBox(height: 15,),
    ListTile(
      title: Text('My Order'),
      leading: Icon(CupertinoIcons.shopping_cart,size: 30,),
      onTap: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>OrdersPage()));},

    ),
    SizedBox(height:15),
    ListTile(
        title: Text('About'),
        leading: Icon(CupertinoIcons.info,size: 30,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));

        },
      ),
       SizedBox(height:15),
    ListTile(
        title: Text('Logout'),
        leading: Icon(Icons.exit_to_app,size: 30,),
        onTap: ()async {
          /*SharedPreferences pref=await SharedPreferences.getInstance();
          pref.remove('username');*/
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          

        },
      ),
    ],
   
      
    )
    );
  }
}
