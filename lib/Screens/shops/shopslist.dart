import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kan_market/Models/area.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/styles.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:kan_market/Screens/shops/shoppage.dart';
import 'package:http/http.dart';
import 'package:convert/convert.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';


class ShopsList extends StatelessWidget {
  final String category;
  final String area;
 
  ShopsList(this.area,this.category);
  @override
Future<List<Shop>>_getshops()async
{
  
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

  }
  //filtering shops by area and category
  List<Shop> fshops=[];
  for(int i=0;i<shops.length;i++)
  {
    if( shops[i].area==area && shops[i].category==category){
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
return(

    FutureBuilder( future: _getshops(),
    builder:( BuildContext context,AsyncSnapshot asn){
      if(asn.data==null)
      {
        return  Center(child:CircularProgressIndicator());
        //return Container(child: Center(child:Text('Loading')),);
      }
      else
       return ListView.builder(
      itemCount: asn.data.length,
      itemBuilder: (BuildContext context,int index)
      {
        return GestureDetector(child: Card(
          
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(height: 300,width: 500,child:
          CachedNetworkImage(imageUrl: asn.data[index].image_url,
          placeholder: (context, url) => Image.asset('assets/images/logo.png'),
          errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit:BoxFit.cover,
                                  ),
          
           
          ),
          Padding(padding:EdgeInsets.only(left:18),child:Text(asn.data[index].name,style:bodyTextl)),

          ListTile(
            title: Text(asn.data[index].category,style: bodyText),
            subtitle: Text(asn.data[index].area,style: bodyTexts,),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder:(Context)=>ShopePage(asn.data[index])));
            },
          ),
           
           SmoothStarRating(
            starCount:5,
            rating: asn.data[index].rate.toDouble(),
            size: 30.0,
            spacing: 1.0,
            isReadOnly: true,
            color: Colors.pink[300],
            borderColor: Colors.pink[300],
          ),
          SizedBox(height:13,)
          

          
          
          ]
        )
        )
        ,onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(Context)=>ShopePage(asn.data[index])));
        },
        );
      }


      
    
    );
    }
    )
    );

  }

}
