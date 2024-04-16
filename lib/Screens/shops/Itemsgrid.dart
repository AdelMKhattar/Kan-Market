import 'package:flutter/material.dart';
import 'package:kan_market/Models/item.dart';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/styles.dart';
import 'package:kan_market/Screens/items/ItemPage.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

class ItemsGrid extends StatefulWidget {
  @override
  final shopid;
 
  ItemsGrid(this.shopid);
  _ItemsGridState createState() => _ItemsGridState(shopid);
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

class _ItemsGridState extends State<ItemsGrid> {
  @override
  final int shopid;
 
  _ItemsGridState(this.shopid);
  Widget build(BuildContext context) {
    return FutureBuilder(future: _shopItems(shopid.toString()),builder: (BuildContext context,AsyncSnapshot asn){
      if(asn.data==null){ return Center(child: CircularProgressIndicator(),);}
      else{
    //return Container(child: Text('Done'),);
     return GridView.count(
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 1/1.25,
      children: asn.data.map<Widget>((product) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Hero(
                              tag: product.item_id,
                              child: AspectRatio(
                                aspectRatio: 1/ 1,
                                child: Stack(children:<Widget>[
                                  //Image.asset("assets/images/logo.png",fit: BoxFit.cover,),
                                  // Image.network(product.image_url,fit:BoxFit.cover)
                                  CachedNetworkImage(imageUrl: product.image_url,
                                  placeholder: (context, url) => Image.asset('assets/images/logo.png'),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit:BoxFit.cover,
                                  ),
                                
                                
                                ]
                                ),
                              ),
                            ),
                            Flexible(child:Text(
                              product.name,style: TextStyle(fontSize: 20,
                              fontWeight:FontWeight.w600,
                              ),
                            )),

                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                         child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemPage(product.item_id,),
                              
                                
                                ));
                          },
                        ),
                        

                      )
                    ],
                  );
                }).toList(),
      
      

      );
      }
      }
      );

  }
}