import 'package:shared_preferences/shared_preferences.dart';
class sharedPreferences{
  static saveToken(String token,String myId) async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setString("token",token);
    pref.setString("myId",myId);
  }
}