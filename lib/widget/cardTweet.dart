import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/pages/profilePages/profilePages.dart';
import 'package:twitter_a/pages/tweetDetailPage/tweetDetailPage.dart';
import 'package:twitter_a/utilites/constants.dart';

class TweetCardWidgets extends StatefulWidget {
  TweetsModel tweet;
  TweetCardWidgets(this.tweet);
  @override
  _TweetCardWidgetsState createState() => _TweetCardWidgetsState();
}
class _TweetCardWidgetsState extends State<TweetCardWidgets> {
  List<int> ids=[1,2,3];
  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder:(context)=> FProfilePages(widget.tweet.myUserId.toString())));},
                          child:Container(
                            width:50,
                            height:50,
                            decoration:BoxDecoration(
                                image:DecorationImage(
                                  image:
                                  (widget.tweet.userImage!=null)?
                                  NetworkImage(MAIN_URL+widget.tweet.userImage) :
                                   Image.asset('assets/shared/abdullah.jpg'),
                                  fit:BoxFit.cover,
                                ),
                                borderRadius:BorderRadius.circular(45)
                            ))
                        ),
                        Padding(
                          padding:EdgeInsets.only(top: 8.0),
                          child:Text('@${widget.tweet.username}',style:TextStyle(fontWeight:FontWeight.bold,fontSize: 15,),),
                        ),
                      ],),
                    SizedBox(height:6),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(widget.tweet.userFullName,style:TextStyle(color:mainLiteBlueColor,fontWeight:FontWeight.bold,fontSize: 15,),),
                        Padding(
                          padding:EdgeInsets.all(5.0),
                          child:Container(
                            height:50,
                            width:200,
                            child:Text(widget.tweet.description),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.all(8.0),
              child:InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                      builder:(context)=>TweetDetailPage(widget.tweet)
                  ));
                },
                child:Container(
                  width:MediaQuery.of(context).size.width*6,
                  height:MediaQuery.of(context).size.height*0.3,
                  child:(widget.tweet.image!= null)?Card(
                    child:Image.network(MAIN_URL+widget.tweet.image,fit:BoxFit.cover,)
                  ):Container(height:3,),
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
                      // ignore: deprecated_member_use
                      child:FlatButton(
                        onPressed:() {
                          print(ids);
                          setState(() {});
                              if (ids.contains(widget.tweet.id)) {
                          ids.remove(widget.tweet.id);
                          } else {
                          ids.add(widget.tweet.id);
                          }
                        },
                        child:ids.contains(widget.tweet.id)?Icon(FontAwesomeIcons.heart,color:Colors.red):
                        Icon(FontAwesomeIcons.heart,color: mainBlackColor,),
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


