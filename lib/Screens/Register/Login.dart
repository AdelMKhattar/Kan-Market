import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/Screens/Register/Register.dart';
import 'package:http/http.dart';
import 'package:convert/convert.dart';
import 'dart:async';
import 'package:kan_market/globals.dart'as globals;
import 'package:kan_market/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  
}
final TextEditingController usernameController=TextEditingController();
final TextEditingController passwordController= TextEditingController();
//var connectivityResult =  (Connectivity().checkConnectivity());
Future<dynamic> _checkLogin(String username,String password)async
{
//String url='http://localhost:8000/api/login';
String url="https://kan-market.1click-hosting.com/api/login";
Response res=await post(url,body:{
  "username":username,
  "password" :password,
});
if(res.statusCode==200){
Map<String,dynamic> response=jsonDecode(res.body);
dynamic s= response["msg"];
//print(s);
return s;
}
}
Future<void>_getUserInfo(String id)async
{
 // String url='http://localhost:8000/api/userinfo';
  String url='https://kan-market.1click-hosting.com/api/userinfo';
  Response res=await post(url,body:{
    "id":id,
  });
 if(res.statusCode==200)
  {
    dynamic b=jsonDecode(res.body);
    dynamic body=b['user'];
    User user=User( body["id"], body["firstname"], body["lastname"], body["username"]);

    globals.firstname=user.firstname;
    globals.lastname=user.lastname;
    globals.username=user.username;
    globals.userid=user.id;
  }
}



final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
class _LoginState extends State<Login> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.pink[300]),),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold,color:Colors.amber[200])),
                  ),
              

        ]
        )
      ),
                Padding(padding:EdgeInsets.fromLTRB(15, 2, 0, 0),
                  child:Text('Please Log in to Continue',style: TextStyle(
                    fontSize: 20 ,
                    color: Colors.black,
                    fontWeight:FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ), 
                  )
                  ),
                  Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),

                child: Form(key: _formkey,
                  child:Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'User Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                              controller:usernameController ,
                       validator: (String value)
                       {
                         if(value.isEmpty) return 'Please Enter Your User Name';
                       },  
                       
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      controller: passwordController,
                      validator: (String value)
                      {
                        if(value.isEmpty)
                        return 'Please Enter Your Password';
                       
                        
                        
                      },
                    ),
                     


                    SizedBox(height:25),
                    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to KanMarket?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                  
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            
            SizedBox(height:35),
            FlatButton( child:Padding(padding:EdgeInsets.fromLTRB(60,20,60,20)
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
                             if(_formkey.currentState.validate()){
                            final String email=usernameController.text;
                            final String password=passwordController.text;
                            dynamic res= await _checkLogin(email, password);
                            
                            if(res==null){ return Center(child:CircularProgressIndicator());}
                            else if(res=="invalid username" || res=='invalid password')
                            {
                             return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(res),));
                              
                              
                            }
                            else
                            {
                              print(res);
                             /* SharedPreferences pref=await SharedPreferences.getInstance();
                              pref.setString('username', email);*/
              
                              _getUserInfo(res.toString());
                             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ChooseCategory()));             
                             
                            }
         
                            }
            

                            },       

            ), 
            /* GestureDetector(
                          onTap: () async{
                            //Navigator.push(context,MaterialPageRoute(builder: (context)=>ChooseCategory()));  
                            final String email=usernameController.text;
                            final String password=passwordController.text;
                            dynamic res= await _checkLogin(email, password);
                            if(_formkey.currentState.validate()){

                            if(res==null){ return Center(child:CircularProgressIndicator());}
                            else if(res=="invalid username" || res=='invalid password')
                            {
                             return showDialog(context: context,builder:(_)=>AlertDialog(content: Text(res),));
                              
                              
                            }
                            else
                            {
                              print(res);
                             /* SharedPreferences pref=await SharedPreferences.getInstance();
                              pref.setString('username', email);*/
              
                              _getUserInfo(res.toString());
                             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ChooseCategory()));             
                             
                            }
         
                            }
            
                            
                          },
                   child:Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        
                        ),
                      
                      )
                      ),*/
                     
                    ]
                )
                              
                              )
                   )
        
          ],
      ),
    )
    )
    );
  }
}