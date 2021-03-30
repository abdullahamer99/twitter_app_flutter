import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twitter_a/api/tweetapi.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/cardTweet.dart';

class SearchPages extends StatefulWidget {
  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  TextEditingController searchTextController=TextEditingController();
   String inputValue;
   @override
  void initState() {
  searchTextController.text=inputValue;
  super.initState();
  }
  @override
  void dispose() {
  searchTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Find what you want',style:TextStyle(color:mainWhiteColor),),
        centerTitle:true,
      ),
      body:SingleChildScrollView(
        child:Column(
          children: [
            Padding(
              padding:EdgeInsets.all(10),
              child:TextFormField(
                controller:searchTextController,
                decoration:InputDecoration(
                  hintText:"Write Search word",
                  prefixIcon:Icon(Icons.search),
                  border:InputBorder.none,
                ),
              ),
            ),
            FlatButton(
              onPressed:(){
               setState(() {
                 inputValue=searchTextController.text;
               });
              },
                child:Text("search",style:TextStyle(color:mainWhiteColor),),
              color:mainLiteBlueColor,
              ),
            Container(
              height:MediaQuery.of(context).size.height*0.6,
              child:FutureBuilder(
                  future:fetchSearchTweets(searchTextController.text),
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
            ),
          ],
        ),
      ),
    );
  }
}
