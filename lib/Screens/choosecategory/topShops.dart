import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:kan_market/Screens/shops/shoppage.dart';
import 'package:kan_market/globals.dart'as globals;

class TopShops extends StatelessWidget {
  @override

  
   Future<List<Shop>>_getTopShops()async
{
  //String url='http://192.168.1.104:8000/api/allshops';
  String url="https://kan-market.1click-hosting.com/api/allshops";
  try {
    Response data=await get(url);

  Map<String,dynamic> body= jsonDecode(data.body);
  List<dynamic> b=body["shop"];
  List<Shop> shops=[];
 // print(b);
 // print(b[1]["area"]); 
  for(var d in b)
  {
    Shop shop=Shop(d ["shop_id"],d["name"],d["number"] ,d["area"],d["category"],d["Rate"],d["image_url"]);
    shops.add(shop);
    globals.sh.add(shop);

  }
  //filtering shops by rates
  List<Shop> fshops=[];
  for(int i=0;i<shops.length;i++)
  { 
    if(shops[i].rate==5)
    {
      fshops.add(shops[i]);
    }
   
  }
    
  
  return fshops;
  
  }
  catch (e) {
    print(e);
  }
}

  Widget build(BuildContext context) {
   return FutureBuilder(future:_getTopShops(),builder:(BuildContext context,AsyncSnapshot asn)
    {
      if(asn.data==null){return Center(child:CircularProgressIndicator());}
      else
      {
       return ListView.builder(itemCount:asn.data.length,itemBuilder: (BuildContext context, int index)
       {
        return Padding(padding:EdgeInsets.fromLTRB(5, 2, 5, 1) ,child:
         GestureDetector(child:Card(child: Column(crossAxisAlignment:CrossAxisAlignment.start,
        children:<Widget>
        [ 

          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:<Widget>[
           Padding(padding:EdgeInsets.only(left:7), child:Text(asn.data[index].name,
           style: TextStyle(fontSize: 25),
           )),
           Padding(padding: EdgeInsets.only(right:7),child:
            SmoothStarRating(
            size: 18,
           starCount:5,
           rating:asn.data[index].rate.toDouble() ,
           allowHalfRating: false,
           isReadOnly:true,
           color:Colors.pink[300],
           borderColor:Colors.pink[300],
         )),
         ]
         ),
         ListTile(
           leading: Icon(Icons.store),
           title:Text(asn.data[index].category),
           subtitle: Text(asn.data[index].area),
           onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ShopePage(asn.data[index])));},
         )
          
          

        ]

        )
        ,),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ShopePage(asn.data[index])));
        },
        ),
        );
        
      

       }
        
       
       
       );

      }

    }
    );

   
   

  }

}