import 'dart:convert';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_a/model/myuser.dart';
import 'package:twitter_a/model/tweetModel.dart';
import 'package:twitter_a/model/userModel.dart';
import 'package:twitter_a/utilites/constants.dart';
  var header = {
    "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTksImlhdCI6MTYwODQ3MTQ1NiwiZXhwIjoxNjExMDYzNDU2fQ.XAMDQcXGaZNlo9AFMlVOOfxbSA5aSMxaW0WX1ANMP-w"
  };
  Future<List<TweetsModel>> fetchTweets() async {
    http.Response response = await http.get("https://apitwitte21r.herokuapp.com/tweets");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<TweetsModel> tweets = [];
      print(body);
      for (var tweet in body) {
        tweets.add(TweetsModel.fromJson(tweet));
      }
      return tweets;
    }else{
      print(response.statusCode);
    }
    return null;
  }

  Future<List<TweetsModel>> fetchLOGONTweets(String id) async {
  http.Response response = await http.get(LOGIN_USER_TWEETS_URL+id);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    List<TweetsModel> tweets = [];
    print(body);
    for (var tweet in body) {
      tweets.add(TweetsModel.fromJson(tweet));
    }
    return tweets;
  }else{
    print(response.statusCode);
  }
  return null;
}

  Future<List<TweetsModel>> fetchSearchTweets(String inputText) async {
  http.Response response = await http.get(SEARCH_URL+inputText);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    List<TweetsModel> tweets = [];
    print(body);
    for (var tweet in body) {
      tweets.add(TweetsModel.fromJson(tweet));
    }
    return tweets;
  }else{
    print(response.statusCode);
  }
  return null;
}

  Future<UserModel> fetchMyAccountId(String id) async {
    http.Response response = await http.get("https://apitwitte21r.herokuapp.com/users/"+id);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      return UserModel.fromJson( body);
    }else{
      print(response.statusCode);
    }
    return null;
  }

  Future<MeModel> fetchMyAccount( ) async {
      http.Response response = await http.get("http://192.168.0.114:1337/users/2");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
      print(body);
      return MeModel.fromJson(body);
    }else{
      print(response.statusCode);
    }
    return null;
  }

