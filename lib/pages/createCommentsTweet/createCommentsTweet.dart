import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/utilites/constants.dart';
class CreateCommentsTweet extends StatefulWidget {
  @override
  _CreateCommentsTweetState createState() => _CreateCommentsTweetState();
}
class _CreateCommentsTweetState extends State<CreateCommentsTweet> {
  String myId=prefs.getString("myId");
  TextEditingController _textTweetController=TextEditingController();
  @override
  void dispose() {
    _textTweetController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        leading:IconButton(
          icon:Icon(Icons.close,color:mainLiteBlueColor),
          onPressed: () {  Navigator.pushReplacement(context, MaterialPageRoute(
            builder:(context)=> NavigationControlPage(0),)); },),
     ),
      body:Center(
        child: SingleChildScrollView(
        child:Column(
            children: [
          Padding(
                padding:EdgeInsets.all(8),
                child:Row(
                  children: [
                    Padding(
                      padding:EdgeInsets.all(8),
                      child:Container(
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
                    ),
                    Padding(
                      padding:EdgeInsets.all(8),
                      child:Container(
                        width:MediaQuery.of(context).size.width*0.7,
                        height:50,
                        child:TextFormField(
                          controller:_textTweetController,
                          maxLines:10,
                          decoration:InputDecoration(
                            hintText: "Write Your Comments",
                            border:InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed:(){},
                child:Container(
                  height:35,
                  width:155,
                  decoration:BoxDecoration(
                    color:mainLiteBlueColor,
                    borderRadius:BorderRadius.circular(15)
                  ),
                  child:Center(child: Padding(
                    padding:EdgeInsets.all(5.0),
                    child:Text('Comments',style:TextStyle(color:mainWhiteColor,fontSize:17),
                    ),
                  )
                  ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}













