import 'package:kan_market/globals.dart'as globals;
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';

class OrdersPage extends StatelessWidget {
  @override
  var scafoldkey= GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold( key: scafoldkey,
      drawer: MyDrawer(),
      body: Container(
      child: SafeArea(child: Column( crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
           Padding(padding:EdgeInsets.fromLTRB(2, 5, 0, 0) ,
       child:IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer()),
       ),
       SizedBox(height:25),
       Center(
       child: Text('Your Orders', style:titleText,),
       ),
      
       Flexible(child: 
       ListView.builder(itemCount: globals.i.length,itemBuilder: (BuildContext context, int index)
       {
         return ListTile(
           title:Text(globals.i[index].name),
           subtitle: Text(globals.i[index].price.toString()),
         );

       }
       
       
       ))
       
       ],
      
    )
    )
    )
    );
  }
}
