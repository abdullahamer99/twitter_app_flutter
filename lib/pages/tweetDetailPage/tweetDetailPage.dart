import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/pages/createCommentsTweet/createCommentsTweet.dart';
import 'package:twitter_a/pages/createTweetPage/createTweetPage.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/cardTweet.dart';

class TweetDetailPage extends StatefulWidget {
  TweetsModel tweet;
  TweetDetailPage(this.tweet);

  @override
  _TweetDetailPageState createState() => _TweetDetailPageState();
}

class _TweetDetailPageState extends State<TweetDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mainLiteBlueColor,
        title:Icon(FontAwesomeIcons.twitter,size:40,),
        centerTitle:true,
        leading:InkWell(
          onTap:(){
            Navigator.pushReplacement(context,MaterialPageRoute(
              builder:(context)=>NavigationControlPage(0)));
          },
          child:Icon(Icons.arrow_back,color:mainWhiteColor,),
        ),
      ),
      floatingActionButton:FloatingActionButton(
      child:Icon(FontAwesomeIcons.commentAlt),
      onPressed:(){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder:(context)=> CreateCommentsTweet(),));
      },
    ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            TweetCardWidgets( widget.tweet),
            Padding(
              padding:EdgeInsets.only(left:6),
              child:Text("Comments",style:TextStyle(color:mainBlackColor,fontSize:20,fontWeight:FontWeight.bold),),
            ),

            cardComments()
          ],
        ),
      ),
    );
  }
  // ignore: missing_return
  Widget cardComments(){
    return  Padding(
      padding:EdgeInsets.all(9),
      child:Container(
        height:600,
        child:ListView.builder(
            itemCount:10,
            itemBuilder:(context,index){
              return Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Container(
                    width:60,
                    height:60,
                    decoration:BoxDecoration(
                        image:DecorationImage(
                          image:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDG10YnXjsQMxhLE-bNc3NFWZmBfqCCXfiYQ&usqp=CAU"),
                          fit:BoxFit.cover,
                        ),
                        borderRadius:BorderRadius.circular(45)
                    ),
                  ),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:EdgeInsets.all(8.0),
                        child:Container(
                          height:50,
                          width:250,
                          child:Text("first comments to twitter",style:TextStyle(
                         color:mainBlackColor,fontSize:15,fontWeight:FontWeight.bold),),
                        ),
                      ),
                      Text("Abdullah Amer",style:TextStyle(
                          color:mainBlackColor,fontSize:15,fontWeight:FontWeight.bold),),
                    ],),
                ],
              );
            }),
      )
    );
  }
}
