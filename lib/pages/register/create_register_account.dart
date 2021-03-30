import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_a/main.dart';
import 'package:twitter_a/pages/alert/alert.dart';
import 'package:twitter_a/pages/home/homePage.dart';
import 'dart:convert';
import 'package:twitter_a/api/sharedPreferences.dart';
import 'package:twitter_a/pages/loginaccount/loginaccount.dart';
import 'package:twitter_a/utilites/constants.dart';
import 'package:twitter_a/widget/coustmer_input_text.dart';
class CreateRegisterAccount extends StatefulWidget {
  @override
  _CreateRegisterAccountState createState() => _CreateRegisterAccountState();
}
class _CreateRegisterAccountState extends State<CreateRegisterAccount> {
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController usernameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  @override
  void dispose() {
    nameTextEditingController.dispose();
    usernameTextEditingController.dispose();
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
                    padding: EdgeInsets.all(18),
                    child: SingleChildScrollView(
                      child:  Container(
                          width:400,
                          height: 450,
                          decoration: BoxDecoration(
                            color:mainWhiteColor,
                            borderRadius:BorderRadius.only(
                                topLeft:Radius.circular(5),
                                bottomRight:Radius.circular(5),
                                topRight: Radius.circular(5)
                            ),
                          ),
                          child:Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                                child:Text('Create your Account, Now!',
                                  style: TextStyle(color:mainBlackColor,fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                              CumotumerInputField(hintText: 'Full Name',secure:false,controller:nameTextEditingController),
                              CumotumerInputField(hintText: 'User Name',secure:false,controller:usernameTextEditingController),
                              CumotumerInputField(hintText: 'Email',secure:false,controller:emailTextEditingController),
                              CumotumerInputField(hintText: 'Password',secure:true,controller:passwordTextEditingController),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal:70,vertical: 10),
                                  child:Container(
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.all(Radius.circular(6)),
                                      color:mainDarkBlueColor,
                                    ),
                                    child:FlatButton(
                                      onPressed: ()async{
                                       _registerAccount();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Register',
                                            style: TextStyle(color:mainWhiteColor,
                                                fontSize: 21,fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child:FlatButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => LoginAccount()),);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('If you have Account? Login',
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
            )
        ),
      ),
    );
  }
   // ignore: missing_return
   Future<Widget> _registerAccount()async{
     var header = {
       "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImlhdCI6MTYwODQ3MTQ1NiwiZXhwIjoxNjExMDYzNDU2fQ.XAMDQcXGaZNlo9AFMlVOOfxbSA5aSMxaW0WX1ANMP-w"
     };

     var response= await http.post("https://apitwitte21r.herokuapp.com/auth/local/register",
        body: {
      "username": usernameTextEditingController.text,
      "email": emailTextEditingController.text,
      "password": passwordTextEditingController.text,
      "fullName": nameTextEditingController.text
    },
    );
    if(response.statusCode==200){
      print("Create Account " + response.body);
      var body= jsonDecode(response.body);
      sharedPreferences.saveToken(body["jwt"],body["user"]["id"].toString());
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => HomePage()),);
    }else{
      print("Not Create Account ***");
     // print(prefs.getString("token"));
      var body= jsonDecode(response.body);
      String a=body["message"][0]["messages"][0]["message"];
      WidgetAlertError.Alerts(context,a,"");
    }
  }
}
