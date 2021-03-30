import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/api/tweetapi.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/pages/home/homePage.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/cardTweet.dart';

class NewTweetPage extends StatefulWidget {
  @override
  _NewTweetPageState createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        title:Icon(FontAwesomeIcons.twitter,color:mainLiteBlueColor,size:40,),
        centerTitle:true,
        actions: [
          Padding(
            padding:EdgeInsets.all(8.0),
            child:Icon(Icons.whatshot
              ,color:mainLiteBlueColor,size:30,),)],
      ),
      body:SingleChildScrollView(
        child:Column(
          children: [
            Container(
              width:MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height*0.9,
              child:FutureBuilder(
                  future:fetchTweets(),
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
                                return newTweet( tweets[index]);
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
  Widget newTweet(TweetsModel tweet){
    return Padding(
      padding:EdgeInsets.all(5),
      child:Card(
          child:Padding(
              padding:EdgeInsets.all(5),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [

                  (MAIN_URL+ tweet.userImage != null) ?Container(
                    width:70,
                    height:70,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(45),
                      image:DecorationImage(
                          image:NetworkImage(MAIN_URL+ tweet.userImage),
                          //  image:ExactAssetImage("assets/images/team.png"),
                          fit:BoxFit.cover
                      ),),
                  ):Container(
                    width:70,
                    height:70,
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(45),
            image: DecorationImage(

            image: ExactAssetImage('assets/shared/abdullah.jpg'), fit: BoxFit.cover,),),),
                  InkWell(
                    onTap:(){
                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => NavigationControlPage(0)));
                    },
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:EdgeInsets.all(5.0),
                              child:Text(tweet.userFullName,style:TextStyle(
                                  color:mainLiteBlueColor,fontSize:20
                              ),),
                            ),
                            Icon(Icons.auto_awesome,color:mainLiteBlueColor, size:30,)
                          ],
                        ),
                        Padding(
                          padding:EdgeInsets.all(5.0),
                          child:Text(tweet.description,style:TextStyle(
                              color:mainBlackColor,fontSize:15
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
      )
    );
  }
}
