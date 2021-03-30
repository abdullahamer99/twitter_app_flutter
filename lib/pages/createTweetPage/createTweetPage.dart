import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/utilites/constants.dart';
class CreateTweetPage extends StatefulWidget {
  String tweet;
  CreateTweetPage(this.tweet);
  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}
class _CreateTweetPageState extends State<CreateTweetPage> {
  String myId=prefs.getString("myId");
  File _image;
  final picker =ImagePicker();
  TextEditingController _textTweetController=TextEditingController();
  Future getImage()async{
    final pickerFile= await picker.getImage(source:ImageSource.camera);
    setState(() {
      if(pickerFile !=null){
        _image =File(pickerFile.path);
      }else{
        print("No image selected.");
      }
    });
  }
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
        actions: [FlatButton(
          onPressed:()async{
            var header = {
              "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImlhdCI6MTYwODQ3MTQ1NiwiZXhwIjoxNjExMDYzNDU2fQ.XAMDQcXGaZNlo9AFMlVOOfxbSA5aSMxaW0WX1ANMP-w"
            };
            Response respons;
            Dio dio= Dio();
            respons= await dio.post("http://192.168.99.104:1337/tweets",data: await addPostData(_image,_textTweetController.text));
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> NavigationControlPage(0),));
          },
          child:Container(
            decoration:BoxDecoration(
                color:mainLiteBlueColor,
                borderRadius:BorderRadius.circular(20)
            ),
            child:Padding(
              padding:EdgeInsets.all(8.0),
              child:Text("Tweet",
                style:TextStyle(color:mainWhiteColor,fontSize:15,fontWeight:FontWeight.normal),),
            ),
          ),

        )],
      ),
      body:SingleChildScrollView(
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
                            image:(MAIN_URL+widget.tweet != null)?NetworkImage(MAIN_URL+widget.tweet):Image.asset('assets/shared/pr.png'),
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
                          hintText: "what is in your mind?",
                          border:InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.all(8),
              child:InkWell(
                  onTap:(){
                    getImage();
                  },
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.all(8),
                        child:Text('Select Image',style:TextStyle(color:mainBlackColor,fontSize:15),),
                      ),
                      Padding(
                        padding:EdgeInsets.all(8),
                        child:Icon(FontAwesomeIcons.image,size:40,color:mainBlackColor,),
                      ),
                    ],
                  )),
            ),
            _image!=null?Container(
              width:200,
              height:200,
              child:Image.file(_image,fit:BoxFit.cover,),
            ):Container()
          ],
        ),
      ),

    );
  }
  //add gettweet api
  Future <FormData> addPostData(File image,String descriptionTweet)async{
    var formData=FormData();
    formData.fields.add(MapEntry("data",'{"description":"$descriptionTweet","users_permissions_user":"$myId"}'));
    if(_image!=null){
      formData.files.add(MapEntry("files.image",
          await MultipartFile.fromFile(image.path,filename: "tweet.png")));
    }
    return formData;
  }
}
