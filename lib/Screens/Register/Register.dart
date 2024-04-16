import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/Register/Login.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:convert/convert.dart';
import 'package:async/async.dart';
import 'package:http/http.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}


final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
final TextEditingController firstnamecontroller=TextEditingController();
final TextEditingController lastnamecontroller=TextEditingController();
final TextEditingController addresscontroller=TextEditingController();
final TextEditingController usernamecontroller=TextEditingController();
final TextEditingController passwordcontroller=TextEditingController();
final TextEditingController phonecontroller=TextEditingController();

Future<String> _register(String firstname,String lastname,String address,String phonenum,String username,String password )async
{
  String url="https://kan-market.1click-hosting.com/api/register";
  Response res= await post(url, body: 
  {
    "firstname":firstname,
    "lastname": lastname,
    "address": address,
    "phone":  phonenum,
    "password": password,
    "username": username,
  });
  if(res.statusCode==200){
  
  Map<String,dynamic> response= jsonDecode(res.body);
  String r= response["msg"];
  print(r);
  return r;
  }
  else
  print(res.body);




}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
 return new Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: Container(child:SingleChildScrollView(child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.pink[300]),
                        
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[300]),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(key:_formkey,
              child:Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        controller: firstnamecontroller,
                      validator: (String value)
                      {
                        if(value.isEmpty) return 'Please Enter Your First Name';
                      },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Last Name ',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        controller: lastnamecontroller,
                      validator: (String value)
                      {
                        if(value.isEmpty)
                        return 'Please Enter Your Last Name';
                      },
                  
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        controller: addresscontroller,
                      validator: (String value)
                      {
                        if(value.isEmpty)
                        return 'Please Enter an Address';
                      },
                  ),
                                    SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        controller: phonecontroller,
                      validator: (String value)
                      {
                        if(value.isEmpty)
                        return 'Please Enter an Address';
                      },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        controller: usernamecontroller,
                        validator: (String value)
                        {
                          if(value.isEmpty)return 'Enter a UserName';
                        },
                  ),

                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                            ),
                             obscureText: true,
                        controller: passwordcontroller,
                          validator: (String value)
                      {
                        if(value.isEmpty)
                        return 'Please Enter a Password';
                      },
                  ),


                  SizedBox(height: 50.0),
                  
                 
                  FlatButton(child:Padding(padding:EdgeInsets.fromLTRB(80,20,80,20)
                                   ,child:Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  fontSize:20,
                                  ),
                            )),color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(20)
                            ),
                            onPressed: ()async
                            {
                   // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ChooseCategory()));             
                               if( _formkey.currentState.validate()){
                          final String firstname= firstnamecontroller.text;
                          final String lastname=lastnamecontroller.text;
                          final String address= addresscontroller.text;
                          final String phonenum=phonecontroller.text;
                          final String username=usernamecontroller.text;
                          final String password=passwordcontroller.text;
                          String response= await _register(firstname, lastname, address,phonenum,username, password);

                       
                         if(response=="register done")
                          {
                       return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(response),));
                            
                          }
                          else
                          {
                          
                            return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(response),));
                            
                    
                          } 
                            }
                            }),
                 /* GestureDetector(
                          onTap: () async{
                             if( _formkey.currentState.validate()){
                          final String firstname= firstnamecontroller.text;
                          final String lastname=lastnamecontroller.text;
                          final String address= addresscontroller.text;
                          final String phonenum=phonecontroller.text;
                          final String username=usernamecontroller.text;
                          final String password=passwordcontroller.text;
                          String response= await _register(firstname, lastname, address,phonenum,username, password);

                       
                         if(response=="register done")
                          {
                       return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(response),));
                            
                          }
                          else
                          {
                          
                            return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(response),));
                            
                    
                          }

                              
                            }
                            
                            
                            },
                            child:  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
    
                          child: Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),*/
                  SizedBox(height: 20.0),
                   FlatButton(child:Padding(padding:EdgeInsets.fromLTRB(80,20,80,20)
                                   ,child:Text(
                              'Back',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  fontSize:20,
                                  ),
                            )),color: Colors.grey[400],
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(20)
                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                            }
                   ),

                ],
              )
              ),
          )
        ]
        )
        )
        )
        );
      
    
  }
}