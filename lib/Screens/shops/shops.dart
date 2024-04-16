import 'package:flutter/material.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';
import 'package:kan_market/Screens/shops/shopslist.dart';

class Shops extends StatefulWidget {
  final String area;
  final String category;
  
  Shops(this.area,this.category);
  @override
  _ShopsState createState() => _ShopsState(area,category);
}

class _ShopsState extends State<Shops>{
  final String area;
  final String category;
  
  _ShopsState(this.area,this.category,);
  var scafoldkey= GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(key: scafoldkey,
      drawer: MyDrawer(),
      body: Container(
      height:screenHeight,
      width:screenWidth,
      child: Column( crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
           Padding(padding:EdgeInsets.fromLTRB(2, 20, 0, 0) ,
       child:IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer()),
       ),
       SizedBox(height:25),
       Center(
       child: Text('Shop from ', style: titleText
       )
       ),
       Flexible(child: ShopsList(area,category)),
              
       
       ]
       )
       )
       


    );
     
      
  }
}