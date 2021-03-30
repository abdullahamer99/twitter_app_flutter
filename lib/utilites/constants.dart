import 'package:flutter/material.dart';


final mainDarkBlueColor=Color(0xff2b76f3);
final mainLiteBlueColor=Color(0xff4198f2);
final mainWhiteColor=Color(0xfffbfcf9);
final mainBlackColor=Color(0xfff0d0c0c);
final mainGrayColor=Color(0xfff687683);

final MAIN_URL ="https://apitwitte21r.herokuapp.com/";

final REGISTER_URL =MAIN_URL +"/auth/local/register";

final LOCAL_URL =MAIN_URL + "/auth/local";

final TWEETS_URL ="https://apitwitte21r.herokuapp.com/tweets";

final LOGIN_USER_TWEETS_URL = MAIN_URL+"/tweets?users_permissions_user=";

final USER_URL = MAIN_URL+"/user/";

final EDITPROFILUSER_URL = MAIN_URL+"/user/";

final USERME_URL =MAIN_URL+"/users/me";

final LIKE_URL = MAIN_URL +"/likes/";

final SEARCH_URL = MAIN_URL+"/tweets?description_contains=";
