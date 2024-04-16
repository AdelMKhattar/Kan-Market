import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';
import 'searchbar.dart';
import 'categorywidgetarea.dart';
import 'package:kan_market/Screens/choosecategory/topShops.dart';
import 'package:kan_market/globals.dart'as globals;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:kan_market/Models/user.dart';

class ChooseCategory extends StatefulWidget {

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}


class _ChooseCategoryState extends State<ChooseCategory> {
  
  
_ChooseCategoryState();
  var scafoldkey= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

   var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    
    return Scaffold( key: scafoldkey,
      drawer: MyDrawer(),
      body: Container(
      height:screenHeight,
      width:screenWidth,
      child: SafeArea(child: Column( crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
           Padding(padding:EdgeInsets.fromLTRB(2, 5, 0, 0) ,
       child:IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer()),
       ),
       SizedBox(height:25),
       Center(
       child: Text('What are You \nLooking For ?', style: titleText,)
       
       ),
       SearchBar(),
       
       CategoriesWidget(),
       SizedBox(height:15),

       Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text('Top Shops: ',style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600),) ,),
        
       Flexible(child: TopShops(),)
          

    

      ],
     
      
      )
      )
      
      )
      );
  }
}