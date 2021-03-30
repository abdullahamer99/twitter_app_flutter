import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/pages/register/create_register_account.dart';
import 'package:twitter_a/utilites/constants.dart';

import '../pages/loginaccount/loginaccount.dart';

class StartHome extends StatefulWidget {
  @override
  _StartHomeState createState() => _StartHomeState();
}

class _StartHomeState extends State<StartHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(
          begin:Alignment.topRight,
          end: Alignment.bottomLeft ,
          stops: [0.3,0.6,0.7,0.9],
          colors: [
            mainDarkBlueColor,
            mainLiteBlueColor,
            mainDarkBlueColor,
            mainLiteBlueColor],

      ),),
      child:Scaffold(
          backgroundColor: mainDarkBlueColor,
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child:Row(
                  children: [
                    Icon(FontAwesomeIcons.twitter,color: mainWhiteColor,size: 40,),
                    Text('Twitter',style: TextStyle(color: mainWhiteColor,
                        fontSize: 30,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child:Container(
                  width: 200,
                  height: 100,
                  child: Text('See whats`s happening in the world right now',
                    style: TextStyle(color: mainWhiteColor,
                        wordSpacing: 5,fontSize: 25,fontWeight: FontWeight.bold),),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:  FlatButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>LoginAccount()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Log in to twitter',
                            style: TextStyle(color: mainWhiteColor,
                                fontSize: 17,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.all(11),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration:BoxDecoration(
                                color: mainWhiteColor,
                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            child:Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child:FlatButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>CreateRegisterAccount()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create new account',
                            style: TextStyle(color: mainWhiteColor,
                                fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration:BoxDecoration(
                                color:Colors.transparent,
                                border: Border.all(color:mainWhiteColor),
                                borderRadius: BorderRadius.all(Radius.circular(14))
                            ),
                            child:Icon(Icons.arrow_forward_ios,color: mainWhiteColor,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
