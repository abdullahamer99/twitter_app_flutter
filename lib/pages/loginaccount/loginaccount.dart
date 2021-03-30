import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_a/pages/alert/alert.dart';
import 'package:twitter_a/pages/home/homePage.dart';
import 'package:twitter_a/pages/register/create_register_account.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/coustmer_input_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:twitter_a/api/sharedPreferences.dart';
class LoginAccount extends StatefulWidget {
  @override
  _LoginAccountState createState() => _LoginAccountState();
}
class _LoginAccountState extends State<LoginAccount> {
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor:mainDarkBlueColor,
        appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0,
         ),
         body:Center(
           child:SingleChildScrollView(
             child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:[
               Padding(
                 padding: EdgeInsets.only(right:18,top:18,bottom:18),
                 child: SingleChildScrollView(
                   child:  Container(
                     width:400,
                     height: 350,
                     decoration: BoxDecoration(
                       color:mainWhiteColor,
                       borderRadius:BorderRadius.only(
                           // topLeft:Radius.circular(5),
                           bottomRight:Radius.circular(5),
                           topRight: Radius.circular(5)
                       ),
                     ),
                     child:Column(
                       children: [
                         Padding(
                           padding: EdgeInsets.only(top: 40),
                           child:Text('Login to your Account, Now!',
                             style: TextStyle(color:mainBlackColor,fontWeight: FontWeight.bold,fontSize: 20),),
                         ),
                         CumotumerInputField(hintText: 'Enter your Email',secure:false,controller:emailTextEditingController),
                         CumotumerInputField(hintText: 'Enter your Password',secure:true,controller:passwordTextEditingController),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal:70,vertical: 10),
                           child:Container(
                             decoration:BoxDecoration(
                               borderRadius:BorderRadius.all(Radius.circular(6)),
                               color:mainDarkBlueColor,
                             ),
                             // ignore: deprecated_member_use
                             child:FlatButton(
                               onPressed: ()async{
                                 _LoginToAccount();
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text('Login',
                                     style: TextStyle(color:mainWhiteColor,
                                         fontSize: 21,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             ),
                           )
                         ),
                         Padding(
                           padding: EdgeInsets.all(5),
                           child:Text('Forget Password?',
                             style: TextStyle(color:mainBlackColor,
                                 fontWeight: FontWeight.bold,fontSize: 15),),
                         ),
                       ],
                     )
                     ),
                   ),
                 ),
               Padding(
                 padding: EdgeInsets.only(top: 30),
                 // ignore: deprecated_member_use
                 child:FlatButton(
                   onPressed: (){

                   },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       FlatButton(
                         onPressed:(){
                           Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => CreateRegisterAccount()),);

                         },
                         child:Text('Create new account',style: TextStyle(color: mainWhiteColor,
                             fontSize: 16,fontWeight: FontWeight.bold),),
                         ),
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
           )
         ),
       ),
    );
  }
  // ignore: non_constant_identifier_names
  Future<Widget> _LoginToAccount()async{
    var response= await http.post(LOCAL_URL,body: {
      "email": emailTextEditingController.text,
      "password": passwordTextEditingController.text,
    });
    if(response.statusCode==200){
       var body= jsonDecode(response.body);
      print("Create Account " + response.body);
      print(body["message"][0]["message"][0]["message"]);
      sharedPreferences.saveToken(body["jwt"],body["user"]["id"].toString());
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => HomePage()),);
       WidgetAlertError.Alerts(context,"Succaeful","");
    }else{
      print("Create no ");
      var body= jsonDecode(response.body);
      String a=body["message"][0]["messages"][0]["message"].toString();
      print(a);
      WidgetAlertError.Alerts(context,a,"");
    }
  }
}

