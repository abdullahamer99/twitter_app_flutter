import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_a/api/tweetapi.dart';
import 'package:twitter_a/control/starthome.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/model/userModel.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/api/sharedPreferences.dart';
class FProfilePages extends StatefulWidget {
  String userId;
  FProfilePages(this.userId);
  @override
  _FProfilePagesState createState() => _FProfilePagesState();
}
class _FProfilePagesState extends State<FProfilePages> {
  // String myId=prefs.getString("myId");
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mainLiteBlueColor,
        title:Icon(FontAwesomeIcons.twitter,size:40,),
        centerTitle:true,
      ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future:fetchMyAccountId(widget.userId),
                // ignore: missing_return
                builder: ( context, snapshot){
            switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return Text(snapshot.error);
                      break;
                    case ConnectionState.waiting:
                      return Center(child:CircularProgressIndicator(backgroundColor:mainDarkBlueColor,),);
                      break;
                    case ConnectionState.active:
                      return Center(child:CircularProgressIndicator(backgroundColor:mainDarkBlueColor,),);
                      break;
                    case ConnectionState.done:
                      UserModel myUser=snapshot.data;
                      return  headProfile(myUser);
                      break;
                  }}),
            Padding(
              padding:EdgeInsets.only(left: 8.0,top: 50),
              child:Text("My Tweet",style:TextStyle(
                  color:mainDarkBlueColor,fontSize:20,fontWeight:FontWeight.bold),),
            ),
            Container(
              height:500,
              child:ListView.builder(
                itemCount:10,
                itemBuilder:(context,index){
                  return tweetCard('first tweet 21',"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZR7cUPf7dwlO3L5MIXLTuYPvUgQSWCDGcEQ&usqp=CAU");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget headProfile(UserModel myUser){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height*0.3,
              child:Image.network(MAIN_URL+myUser.bannar,fit:BoxFit.cover,),
            ),
            Padding(
              padding:EdgeInsets.all(8.0),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Transform.translate(
                    offset:Offset(8,190),
                    child:  Container(
                      width:90,
                      height:90,
                      decoration:BoxDecoration(
                        image:DecorationImage(
                          image:NetworkImage(MAIN_URL+myUser.image),
                          fit:BoxFit.cover,
                        ),
                        borderRadius:BorderRadius.circular(45),
                        border:Border.all(color:mainWhiteColor,width:4),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset:Offset(8,215),
                    child:FlatButton(
                      onPressed:(){},
                      child:Container(
                        decoration:BoxDecoration(
                          color:mainWhiteColor,
                          borderRadius:BorderRadius.circular(20),
                          border:Border.all(color:mainLiteBlueColor),
                        ),
                        child:Padding(
                          padding:EdgeInsets.all(8.0),
                          child:Text("Edit profile",
                            style:TextStyle(color:mainLiteBlueColor,fontSize:15,fontWeight:FontWeight.normal),),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:EdgeInsets.only(left: 8.0),
          child:Transform.translate(
            offset:Offset(5,50),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(myUser.fullName,style:TextStyle(
                    color:mainBlackColor,fontSize:25,fontWeight:FontWeight.bold),),
                Text(' @${myUser.username}',style:TextStyle(
                    color:mainGrayColor,fontSize:15,fontWeight:FontWeight.bold),)
              ],
            ),),
        ),
      ],
    );
  }
  Widget tweetCard(String description,String image){
    return Padding(
      padding: EdgeInsets.all(8),
      child:Container(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Padding(
              padding:EdgeInsets.all(8.0),
              child:Container(
                width:MediaQuery.of(context).size.width*9,
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width:50,
                          height:50,
                          decoration:BoxDecoration(
                              image:DecorationImage(
                                image:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDG10YnXjsQMxhLE-bNc3NFWZmBfqCCXfiYQ&usqp=CAU"),
                                fit:BoxFit.cover,
                              ),
                              borderRadius:BorderRadius.circular(45)
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.only(top: 8.0),
                          child:Text("@username",style:TextStyle(
                            fontWeight:FontWeight.bold,fontSize: 15,),),

                        ),

                      ],),
                    SizedBox(height:6),
                    Padding(
                      padding:EdgeInsets.all(8.0),
                      child:Container(
                        height:50,
                        width:250,
                        child:Text(description),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(8.0),
              child:Container(
                width:400,
                height:250,
                child:Card(
                  child:Image.network(image,fit:BoxFit.cover,),
                ),
              ),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width:42,
                      height:30,
                      child:FlatButton(
                        child:Icon(FontAwesomeIcons.heart),
                        onPressed:(){},
                      ),

                    ),
                    Text('67Likes'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width:42,
                      height:30,
                      child:FlatButton(
                        child:Icon(FontAwesomeIcons.heart),
                        onPressed:(){},
                      ),
                    ),
                    Text('67Comments'),
                  ],
                ),
                Padding(
                  padding:EdgeInsets.all(8.0),
                  child:Divider(thickness:2.0,),
                ),
              ],
            ),
          ],
        ) ,
      ) ,
    );
  }
}
