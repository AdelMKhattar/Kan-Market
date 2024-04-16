import 'package:flutter/material.dart';
import 'package:kan_market/Models/area.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/styles.dart';
import 'package:kan_market/Screens/shops/shops.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';

class AreaList extends StatefulWidget {
  @override
   final String category;
  
  AreaList(this.category);
  _AreaListState createState() => _AreaListState(category);
}
Future<List<Area>> _getAreas() async
{
  String url= "https://kan-market.1click-hosting.com/api/area";
  Response res= await get(url);
  List<dynamic> body=jsonDecode(res.body);
  List<Area> areas=[];
  for(var a in body)
  {
    Area area= Area(a["area"],a["shopNumber"]);
    areas.add(area);
}
 return areas;
}

class _AreaListState extends State<AreaList> {
 
  final String category;
  _AreaListState(this.category);
  Widget build(BuildContext context) {
 return FutureBuilder(future: _getAreas(),builder: (BuildContext context, AsyncSnapshot asn)
     {
       if(asn.data==null){ return Center(child:CircularProgressIndicator());}
       else{

     
    //var screenHeight=MediaQuery.of(context).size.height;
       return ListView.builder(
      
        itemCount: asn.data.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Padding( padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child:Card(
            child: ListTile(
             title: Text(asn.data[index].name,style: bodyText,),
             subtitle: Text("Shops Avalaible "+asn.data[index].numberOfShops.toString(),style:bodyTexts,),
            trailing: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: null),
             onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
             Shops(asn.data[index].name,category)));
             },
            )
          )
          );
         
        },
     
      
    
    );
       }
    }
    );
  }
}
/*class AreaList extends StatelessWidget {
  final String category;
  
  AreaList(this.category);
  
 
  @override
  
  
Future<List<Area>> _getAreas() async
{
  String url= "https://kan-market.1click-hosting.com/api/area";
  Response res= await get(url);
  List<dynamic> body=jsonDecode(res.body);
  List<Area> areas=[];
  for(var a in body)
  {
    Area area= Area(a["area"],a["shopNumber"]);
    areas.add(area);
}
 return areas;
}

  Widget build(BuildContext context) {
     return FutureBuilder(future: _getAreas(),builder: (BuildContext context, AsyncSnapshot asn)
     {
       if(asn.data==null){ return Center(child:CircularProgressIndicator());}
       else{

     
    //var screenHeight=MediaQuery.of(context).size.height;
       return ListView.builder(
      
        itemCount: asn.data.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Padding( padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child:Card(
            child: ListTile(
             title: Text(asn.data[index].name,style: bodyText,),
             subtitle: Text("Shops Avalaible "+asn.data[index].numberOfShops.toString(),style:bodyTexts,),
            trailing: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: null),
             onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
             Shops(asn.data[index].name,category)));
             },
            )
          )
          );
         
        },
     
      
    
    );
       }
    }
    );
  }
}*/