import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:kan_market/Models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SliderWidget extends StatefulWidget {
  @override
  final int id;
  SliderWidget(this.id);
  _SliderWidgetState createState() => _SliderWidgetState(id);
}
Future<List<Item>> _shopItems(String shopId)async
{
String url="https://kan-market.1click-hosting.com/api/items";
Response res= await post(url,body:
{
  "shop_id": shopId.toString()
});
List<dynamic> body= jsonDecode(res.body);
//print(body);
//print(body[0]["name"]);
List<Item> items=[];
for(var i in body)
{
  Item item= Item(i ["item_id"],i ["name"],i ["price"],i ["rate"],i ["feedback"],i ["description"],i ["image_url"]);
  items.add(item);

}

return items;

}


class _SliderWidgetState extends State<SliderWidget> {
  final int id;
  _SliderWidgetState(this.id);

 List img=["assets/images/food.jpeg","assets/images/food.jpeg","assets/images/food.jpeg","assets/images/food.jpeg",];

 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _shopItems(id.toString()),builder:(BuildContext context,AsyncSnapshot asn){ 
      if(asn.data==null){return Center(child:CircularProgressIndicator());}
      else{
      return CarouselSlider( options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                ), 
                 items: asn.data.map<Widget>((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(child:Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(children: <Widget>[
                            CachedNetworkImage(imageUrl: i.image_url,
                            placeholder: (context, url) => Image.asset('assets/images/logo.png'),
                             errorWidget: (context, url, error) => Icon(Icons.error),
                            fit:BoxFit.fill,
                            )
                          ]
                          ),
                        ),
                      ),
                      onTap: ()=>null,
                      );
                    },
                  );
                }).toList(),
                );
      }
                }
                );


 
  }
}