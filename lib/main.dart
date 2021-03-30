import 'package:flutter/material.dart';
import 'file:///C:/Users/Abdullah%20Amer/AndroidStudioProjects/twitter_a/lib/control/starthome.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:twitter_a/control/salomon_bottom_bar.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'pages/home/homePage.dart';

SharedPreferences prefs;

void main() async{
WidgetsFlutterBinding.ensureInitialized();
   prefs = await SharedPreferences.getInstance();
   String token= prefs.getString("token");


Widget _screen;
  if(token== null || token ==""){
      _screen=StartHome();
    }else{
      _screen=NavigationControlPage(0);
    }
runApp(MyApp(_screen));
}
class MyApp extends StatelessWidget {
 final Widget _screen;
  const MyApp(this._screen) ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter 21',
      home:this._screen,
    );
  }
}


