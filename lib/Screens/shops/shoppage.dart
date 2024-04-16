import 'package:flutter/material.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';
import 'package:kan_market/Models/item.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/Screens/shops/sliderwidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:kan_market/Screens/shops/Itemsgrid.dart';
import 'package:http/http.dart' ;
import 'dart:async';
import 'dart:convert';

class ShopePage extends StatefulWidget {
  @override
  final Shop shop;
 
  ShopePage(this.shop);
  _ShopePageState createState() => _ShopePageState(shop);
}
/*Future<List<Item>> _shopItems(String shopId)async
{
String url="https://kan-market.1click-hosting.com/api/items";
Response res= await post(url,body:
{
  "shop_id": shopId.toString()
});
List<dynamic>body= jsonDecode(res.body);
print(body);
print(body[0]["name"]);
List<Item> items=[];
for(var i in body)
{
  Item item= Item(i ["item_id"],i ["name"],i ["price"],i ["rate"],i ["feedback"],i ["description"],i ["image_url"]);
  items.add(item);

}

return items;

}*/


class _ShopePageState extends State<ShopePage> {
   final Shop shop;
   int userid;
   _ShopePageState(this.shop,);
  @override
  var scafoldkey= GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(     
      key: scafoldkey,
      drawer: MyDrawer(),
      body: Container(
        child:SingleChildScrollView(
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
       Padding(padding:EdgeInsets.fromLTRB(2, 25, 0, 0) ,
       child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
         IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer()),
         Row(children: <Widget>[
         IconButton(icon: Icon(Icons.contact_phone), onPressed:(){showDialog(context: context,
         builder:(_)=>AlertDialog(  title:Text(shop.number.toString())),
         );},color: Colors.pink[300],iconSize: 30,),
        ]
         ),
         
       ]
       ),
       
       ),
 
       SizedBox(height:25),
       Center(
       child: Text(shop.name, style: titleText
       )
       ),
       SizedBox(height:20),
       
       SliderWidget(shop.shop_id),

       SizedBox(height:15),

       Padding(padding:EdgeInsets.fromLTRB(10, 2, 5, 2),child:
         Container(child:Column(crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
         Text("Shop Info:",style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600)),
         Text(shop.area,style: bodyTexts,),
         Row(children:<Widget>[
         Text("Rate: ",style: bodyTexts,), 
         SmoothStarRating(
           starCount:5,
           rating:shop.rate.toDouble(),
           allowHalfRating: false,
           isReadOnly:true,
           color:Colors.pink[300],
           borderColor:Colors.pink[300],
         )
         ]
         )
       ],
       )
       )
       ),
       Padding(padding: EdgeInsets.fromLTRB(10, 2, 5, 2),child:Text("Items:",style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600))),
        ItemsGrid(shop.shop_id,),
      


         
          
          ],
        )
      )  
      )  
    );
  
  }
}