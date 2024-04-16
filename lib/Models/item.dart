import 'package:flutter/cupertino.dart';

class Item 
{
  int item_id;
  String name;
  int price;
  int rate;
  String feedback;
  String description;
  String image_url;
  Item(this.item_id,this.name,this.price,this.rate,this.feedback,this.description,this.image_url);
  itemRate(int r){ this.rate=r;}
 itemFeedback(String f){this.feedback=f;}
  
}


List<Item> fetchItems()
{
return([




]);
}
