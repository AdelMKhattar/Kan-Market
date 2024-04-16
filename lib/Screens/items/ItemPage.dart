import 'package:flutter/material.dart';
import 'package:kan_market/Models/item.dart';
import 'package:kan_market/Screens/drawer.dart';
import 'package:kan_market/styles.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:kan_market/globals.dart'as globals;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kan_market/Models/comment.dart';

class ItemPage extends StatefulWidget {
  @override
 final int itemid;

  ItemPage(this.itemid);
  _ItemPageState createState() => _ItemPageState(itemid);
}
//this for taking order and send confermation
Future<dynamic> _order(String userid, String itemid)async
{
  String url='https://kan-market.1click-hosting.com/api/order';
  Response res=await post(url,body:{
   "item_id":itemid,
   "user_id": userid
  });
  if(res.statusCode==200)
  {
    Map<String,dynamic> body=jsonDecode(res.body);
    dynamic response=  body["msg"];
    //print(response);
   return response;
  }
  
}
//this takes the item id and return its details
Future<Item> _getItemDetails(String itemid)async
{
 String url='https://kan-market.1click-hosting.com/api/itemDesc';
 Response res=await post(url,body: {
   "item_id": itemid
 });
dynamic b=jsonDecode(res.body);
dynamic body=b["item"];
 //print(body);
 //print('----------------------------');
 //print(b);
 Item item=Item(body[0]["item_id"],body[0]["name"],body[0] ["price"],body[0] ["rate"],body[0] ["feedback"],body[0] ["description"],body[0]["image_url"]);
 print(item.item_id);
 return item;
}
//future function to add a comment
Future<dynamic> _addComment(String itemid,String userid,String c)async
{
  String url='https://kan-market.1click-hosting.com/api/addComment';
  Response res=await post(url,body:{
    "user_id" :userid,
    "item_id": itemid,
    "comment":c,
  });
  dynamic body=jsonDecode(res.body);
  String response=body["msg"];
  print(response);
  return response;

}
//future function to get comments of an item
Future<List<Comment>> _getcomments(String id)async
{
  String url='https://kan-market.1click-hosting.com/api/getComment';
  Response res=await post(url,body:{
    "item_id":id
  });
  Map<String,dynamic> body=jsonDecode(res.body);
  print(body);
  List<dynamic> c=body["msg"];
  List<Comment> co=[];
  for(var v in c)
  {
    Comment comment=Comment(v["id"],v["user_id"],v["item_id"],v["comment"]);
    co.add(comment);
  }
 
  return co;
}
//update item Rate
Future<dynamic> _updateItemRate(String itemid,String rate)async
{
  String url='https://kan-market.1click-hosting.com/api/itemrate';
  Response res=await post(url,body:{
    "item_id":itemid,
    "rate":rate
  });
  dynamic body=jsonDecode(res.body);
  String response=body["msg"];
  print(response);
  return response;

}

class _ItemPageState extends State<ItemPage> {
  final int itemid;
  
  _ItemPageState(this.itemid,);
  @override
  var scafoldkey=GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return FutureBuilder(future: _getItemDetails(itemid.toString()),builder:(BuildContext context,AsyncSnapshot asn){
      if(asn.data==null){return Center(child:CircularProgressIndicator());}
      else{
    return Scaffold(
      key:scafoldkey,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading:IconButton(icon: Icon(Icons.menu), onPressed:()=> scafoldkey.currentState.openDrawer(),
        color: Colors.black) ,
        centerTitle: true,
        title: Text(asn.data.name,style: titleText,),
        backgroundColor:Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        
      ),
      body: Container(
      //  child:SingleChildScrollView(
        child:
        ListView( //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(tag: asn.data.item_id, 
          
          child: AspectRatio(aspectRatio: 1/1,
            child: CachedNetworkImage(imageUrl: asn.data.image_url,
                                  placeholder: (context, url) => Image.asset('assets/images/logo.png'),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  fit:BoxFit.cover,
                                  ),
            //child:Image.asset('assets/images/logo.png',fit: BoxFit.cover),)
          )),
          Padding(padding: EdgeInsets.fromLTRB(8, 2, 0, 3),
            child:Text(asn.data.name,style:TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w200))
            ),
          Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 3),child: Text('Price: ',style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600),)),
          Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text(asn.data.price.toString(),style: TextStyle(color: Colors.amber[300],fontSize: 25,fontWeight:FontWeight.w700),)),

          Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text('Description: ',style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600),) ,),
          Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text(asn.data.description,style:TextStyle(color:Colors.black,fontSize: 20)) 
          ),
          Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: OutlineButton.icon(
                        icon: Icon(Icons.shopping_cart),
                        label: Text("Order This Product"),
                        onPressed: ()async{
                          
                          globals.i.add(asn.data);
                          print(globals.userid);
                          dynamic res=await _order(globals.userid.toString(),itemid.toString());
                          if(res=="the order is done"){
                          showDialog(context: context,builder:(_)=>AlertDialog(
                            title:Text('Done!'),
                            content:Text('Your Order is on the Way')
                          ));}
                          else{
                             showDialog(context: context,builder:(_)=>AlertDialog(
                            title:Text('Error!'),
                            content:Text('Try again later')
                          ));
                          }
                          
                          
                        }
                      ),  
              ),
        Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text('Rate this Item ',style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600),) ,),
       //Rating item
        Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child: SmoothStarRating(
            starCount:5,
            isReadOnly: false,
            allowHalfRating: false,
           color:Colors.pink[300],
           borderColor:Colors.pink[300],
           onRated: (r)async{
             String res=await _updateItemRate(itemid.toString(), r.toString());
             showDialog(context: context,builder:(_)=>AlertDialog(
                            title:Text('Done!'),
                            content:Text(res)
                          ));

           },
          )
          ),
        //add comment
        Card(elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.all(Radius.circular(20)),
            side: BorderSide(color:Colors.pink[300],width: 5)
          ),
          child:
          Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 5),child:TextField(
            decoration: InputDecoration(labelText: 'Add Comment',labelStyle: TextStyle(color:Colors.black,fontSize: 15)
            ,),
            onSubmitted:(c) async{
              String s=await _addComment(itemid.toString(),globals.userid.toString() ,c);
              if(s==null){return Center(child:CircularProgressIndicator());}
              else{
              showDialog(context: context,builder:(_)=>AlertDialog(
                            title:Text('Thanks!!'),
                            content:Text(s),
                          ));
                          }
                          setState(() {
                            
                          });
            } ,
          )
          )
          ),
          //view comments
          Padding(padding:EdgeInsets.fromLTRB(8, 0, 0, 3),
          child:Text('Comments',style: TextStyle(color: Colors.pink[300],fontFamily: "CherrySwash",fontSize:25.0,fontWeight:FontWeight.w600),) ,),
         
          FutureBuilder(future: _getcomments(itemid.toString()),builder: (BuildContext context, AsyncSnapshot a)
          {
            if(a.data==null){return Center(child: CircularProgressIndicator(),);}
            
            else{
              return Container(constraints: BoxConstraints(maxHeight:200),
                child:ListView.builder(itemCount:a.data.length,itemBuilder:(context,index)=>
              Padding(padding: EdgeInsets.fromLTRB(8, 0, 4, 0),child:Card(elevation:5,child:
              ListTile(title: Text(a.data[index].comment,
              style: TextStyle(
               fontSize: 18,
              ),),)
              )
              )
              )
              );
            }
          }
          
          )
          //
        
         

        ],
        

        
      ),

      )
      
      
    );
      }
    }
    );

  }

}