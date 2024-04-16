import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/chooseaera/areaslist.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';

class ChooseArea extends StatefulWidget {
  final String category;

  ChooseArea(this.category);
  @override
  _ChooseAreaState createState() => _ChooseAreaState(category);
}


class _ChooseAreaState extends State<ChooseArea> {
  final String category;
 
  _ChooseAreaState(this.category);
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
      child: Column( crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
           Padding(padding:EdgeInsets.fromLTRB(2, 20, 0, 0) ,
       child:IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer()),
       ),
       SizedBox(height:25),
       Center(
       child: Text('Choose Your Area', style: titleText
       )
       ),
       Flexible(child: AreaList(category),)
       
       
       ]
       )
       )
       
       
    );
      

      
    
    
   
    
 


      
    
  }
}








