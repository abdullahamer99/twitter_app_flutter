import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/model/userModel.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/coustmer_input_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class EditProfile extends StatefulWidget {
  UserModel tweet;
  EditProfile(this.tweet);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController usernameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();

  @override
  void initState() {
   nameTextEditingController.text=widget.tweet.fullName;
   usernameTextEditingController.text=widget.tweet.username;
   emailTextEditingController.text=widget.tweet.email;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mainLiteBlueColor,
        title:Icon(FontAwesomeIcons.twitter,color:mainWhiteColor,size:40,),
        centerTitle:true,

        actions: [
          Padding(
            padding:EdgeInsets.all(8.0),
            child:FlatButton(
                // ignore: unnecessary_statements
                onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(
                      builder:(context)=>NavigationControlPage(3)));
                },
                child: Icon(Icons.history_edu,color:mainWhiteColor,size:40,)),)],
      ),
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: uploadImage('Upload Your Profile Image'),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: uploadImage('Upload Your Bannar Image'),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          width:280,
                          height:50,
                          child: CumotumerInputField
                            (hintText:"update Full Name ",
                              secure:false,
                              controller:nameTextEditingController)),
                      FlatButton(
                          onPressed:(){
                            upDateDataText(widget.tweet.id.toString(),"fullname",nameTextEditingController.text);
                          },
                          child:Text('Save', style:TextStyle(color:mainLiteBlueColor,
                              fontSize:15,fontWeight:FontWeight.normal),)
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          width:280,
                          height:50,
                          child: CumotumerInputField
                            (hintText:"update userName",
                              secure:false,
                              controller:usernameTextEditingController)),
                      FlatButton(
                          onPressed:(){
                            upDateDataText(widget.tweet.id.toString(),"username",usernameTextEditingController.text);
                          },
                          child:Text('Save', style:TextStyle(color:mainLiteBlueColor,
                              fontSize:15,fontWeight:FontWeight.normal),)
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          width:280,
                          height:50,
                          child: CumotumerInputField
                            (hintText:"update email",
                              secure:false,
                              controller:emailTextEditingController)),
                      FlatButton(
                          onPressed:(){
                            upDateDataText(widget.tweet.id.toString(),"email",emailTextEditingController.text);
                          },
                          child:Text('Save', style:TextStyle(color:mainLiteBlueColor,
                              fontSize:15,fontWeight:FontWeight.normal),)
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
  Widget uploadImage(String title,){
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(title),
        TextButton.icon(onPressed:(){}, icon:Icon(Icons.upload_file), label:Text("Save"))
      ],
    );
  }

  upDateDataText(String id, String key,String value)async{
    http.Response response = await http.put("http://192.168.99.113:1337/users/"+id,body:{
      key:value
    });
    if (response.statusCode == 200) {
    }else{
      print(response.statusCode);
    }
  }
}

