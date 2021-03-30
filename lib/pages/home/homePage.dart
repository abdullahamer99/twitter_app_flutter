import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/api/tweetapi.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/model/userModel.dart';
import 'package:twitter_a/pages/createTweetPage/createTweetPage.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/cardTweet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  UserModel myUserImage=UserModel(int.parse(prefs.getString('myId')), "", "", "", "", "");
  @override
  void initState() {
    fetchMyAccountId(prefs.getString('myId')).then((futureUser){
      myUserImage=futureUser;
    });
  super.initState();
  }
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
            child:Icon(Icons.auto_awesome,color:mainLiteBlueColor,size:40,),)],
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(FontAwesomeIcons.marker),
          onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder:(context)=> CreateTweetPage(MAIN_URL+myUserImage.image),));
          },
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child:Column(
            children:[
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
                                      return TweetCardWidgets( tweets[index]);
                                }),
                              );
                               break;
                           }
                    }),
              )
            ],
          ),
        )),
      );
  }
}

