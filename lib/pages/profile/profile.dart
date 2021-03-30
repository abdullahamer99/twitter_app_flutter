import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_a/api/tweetapi.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/control/starthome.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/model/userModel.dart';
import 'package:twitter_a/pages/profile/editProfile.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/api/sharedPreferences.dart';
class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}
class _ProfilePagesState extends State<ProfilePages> {
 String myId=prefs.getString("myId");
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Image.asset('assets/shared/abdullah.jpg'),
            FutureBuilder(
                future:fetchMyAccountId(myId),
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
                  }
                }),
                Padding(
              padding:EdgeInsets.only(left: 8.0,top: 5),
              child:Text("My Tweet",style:TextStyle(
                  color:mainDarkBlueColor,fontSize:30,fontWeight:FontWeight.bold),),
            ),
                Container(
              height:400,
              child:FutureBuilder(
                  future:fetchLOGONTweets(myId),
                  // ignore: missing_return
                  builder: ( context, snapshot){
                    List<TweetsModel> tweets=snapshot.data;
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
                        return Container(
                          child:ListView.builder(
                              scrollDirection:Axis.vertical,
                              itemCount: tweets.length,
                              itemBuilder: (context,index){
                                return tweetCard(tweets[index]);
                              }),
                        );
                        break;
                    }
                  }),
            )
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
               child:(myUser.bannar!=null)?
                    Image.network(MAIN_URL+myUser.bannar,fit:BoxFit.cover,)
                   :Image.asset('assets/shared/abdullah.jpg'),
            ) ,
            Padding(
              padding:EdgeInsets.all(8.0),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                 Padding(
                    padding:EdgeInsets.only(left: 12.0,top:145),
                    child:Container(
                      width:90,
                      height:90,
                      decoration:BoxDecoration(
                        image:DecorationImage(
                          image:(myUser.image!=null)?
                          NetworkImage(MAIN_URL+myUser.image)
                              :Image.asset('assets/shared/abdullah.jpg'),
                          //fit:BoxFit.cover,
                        ),
                        borderRadius:BorderRadius.circular(45),
                        border:Border.all(color:mainWhiteColor,width:4),
                      ),
                    ),
                   ),
                  Padding(
                        padding:EdgeInsets.only(right: 5.0,top:193),
                      child:RaisedButton(
                        child:Text("Edit profile",
                          style:TextStyle(color:mainWhiteColor,fontSize:15,fontWeight:FontWeight.normal),),
                        color:mainDarkBlueColor,
                        onPressed:(){ Navigator.push(context, MaterialPageRoute(
                            builder:(context)=> EditProfile(myUser)));},
                      ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left: 5.0,top:260),
              child:Text(myUser.fullName,
              style:TextStyle(letterSpacing:1,color:mainBlackColor,fontSize:20,fontWeight:FontWeight.bold),)),
            Padding(
                padding:EdgeInsets.only(left: 5.0,top:280),
                child:Text("@"+myUser.username,
                  style:TextStyle(letterSpacing:1,color:mainBlackColor,fontSize:20,fontWeight:FontWeight.bold),)
            ),
            Transform.translate(
              offset:Offset(305,250),
              child:RaisedButton(
                child:Text("Logout",
                  style:TextStyle(color:mainWhiteColor,fontSize:15,fontWeight:FontWeight.normal),),
                color:Colors.red,
                onPressed:(){
                  sharedPreferences.saveToken("","");
                Navigator.pushReplacement(context,MaterialPageRoute(
                    builder:(context)=> StartHome()));},
              ),

            ),
          ],
        ),
      ],
    );
  }
  Widget tweetCard(TweetsModel tweet){
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
                     (tweet.userImage != null)?
                     Container(
                          width:50,
                          height:50,
                          decoration:BoxDecoration(
                              image:DecorationImage(
                                image:NetworkImage(MAIN_URL+tweet.userImage),
                                fit:BoxFit.cover,
                              ),
                              borderRadius:BorderRadius.circular(45)
                          ),
                        )
                    :Container(
                    width:50,
                     height:50,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/shared/abdullah.jpg'),
                      fit: BoxFit.cover,
                       ),
                     ),
                     ),
                        Padding(
                          padding:EdgeInsets.only(top: 8.0),
                          child:Text("@"+tweet.username,style:TextStyle(
                            fontWeight:FontWeight.bold,fontSize: 15,),),
                        ),
                      ],),
                    SizedBox(height:6),
                    Padding(
                      padding:EdgeInsets.all(8.0),
                      child:Container(
                        height:50,
                        width:250,
                        child:Text(tweet.description),
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
                  child:
                  (MAIN_URL+tweet.image != null)?
                  Card(
                      child:Image.network(MAIN_URL+tweet.image,fit:BoxFit.cover,))
                      :Container(height:3,)))),
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

