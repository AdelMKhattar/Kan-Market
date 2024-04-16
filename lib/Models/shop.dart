import 'package:flutter/foundation.dart';

class Shop 
{
  final int shop_id;
  final String name;
  final int  number;
  final String area;
  final String category;
  final int rate;
  final String image_url;

  Shop(this.shop_id,this.name,this.number,this.area,this.category,this.rate,this.image_url);


/*factory Shop.fromjson(Map<String,dynamic> json)
{
return Shop(shop_id: json["shop_id"] as int,
name: json["name"] as String,
area: json["area"] as String,
category: json["category"] as String,
rate:5

);

}
*/

}



List<Shop> allshops=
[ 
  
];

List<Shop> fetchShops(String ar,String ca)
{
    List<Shop> temp=[];
    for(int i=0;i<allshops.length;i++)
    {
      if(allshops[i].area==ar && allshops[i].category==ca){ 
        temp.add(allshops[i]);
        }
    }
    return temp;
   
}
