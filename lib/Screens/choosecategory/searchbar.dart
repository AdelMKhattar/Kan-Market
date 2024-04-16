import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:kan_market/Models/shop.dart';
import 'package:kan_market/Models/item.dart';
import 'package:kan_market/globals.dart'as globals;
import 'package:kan_market/Screens/shops/shoppage.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding( padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child:Container( 
        
      decoration: ShapeDecoration(shape: StadiumBorder(),color: Colors.red[200],
      ),
      child: Padding(padding: EdgeInsets.fromLTRB(10, 2, 2, 2),
        child:
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.search),
        SizedBox(width: 10,),
        Expanded(child: 
        TextFormField(
          decoration: InputDecoration(
            hintText:' looking for a specific Shop? ',
            hintStyle: TextStyle(fontFamily: "CherrySwash",fontWeight:FontWeight.w300),
    
            border: InputBorder.none,
          ),
         /* onSaved: (s){
             if(showSearch(context: context, delegate: Search())==null){
               showDialog(context: context,builder:(_)=>
               AlertDialog(title:Text('!!'),
               content:Text('No Search'))
               );
             }
          },*/

          onTap: (){

            showSearch(context: context, delegate: Search());
          },
    
        )
        
        )
      ],
        
      )
      ),
    
    

      
      
    )
    );
  }
}
class Search extends SearchDelegate<String>
{
  var sug=[
    globals.sh[0],
    globals.sh[1],
    globals.sh[2],
    globals.sh[3],
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final suglist=query.isEmpty?sug:globals.sh.where((p)=>p.name.startsWith(query)).toList();
    if(globals.sh.where((p)=>p.name.startsWith(query)).toList().isEmpty){return ListTile(title:Text('No Results'));}
    else {return ListView.builder(itemCount: suglist.length,itemBuilder: (context,index)=>

       ListTile(
         title:Text(suglist[index].name),
         onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopePage(suglist[index])));},
       )
    
    
    );
    } 
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suglist=query.isEmpty?sug:globals.sh.where((p)=>p.name.startsWith(query)).toList();
  
    return ListView.builder(itemCount:suglist.length,itemBuilder:(context,index)=>
    ListTile(
      title:RichText(text: TextSpan(text: suglist[index].name.substring(0,query.length),
                    style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: suglist[index].name.substring(query.length),
                        style:TextStyle(color: Colors.grey),
                      )
                    ]
                  
      )
      ),
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopePage(suglist[index])));},
      
    ),
    
    
    );
  }

}