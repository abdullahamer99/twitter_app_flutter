import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:twitter_a/pages/home/homePage.dart';
import 'package:twitter_a/pages/NewTweet/newTweet.dart';
import 'package:twitter_a/pages/profile/profile.dart';
import 'package:twitter_a/pages/search/search.dart';
import 'package:twitter_a/utilites/constants.dart';



class NavigationControlPage extends StatefulWidget {
  int index;

  NavigationControlPage(this.index);

  @override
  _NavigationControlPageState createState() => _NavigationControlPageState();
}

class _NavigationControlPageState extends State<NavigationControlPage> {
 // int _page=0;
  List<Widget>pages=[
    HomePage(),
    SearchPages(),
    NewTweetPage(),
    ProfilePages()
  ];
  void _handleIndexChanged(int index) {
    setState(() {
     widget.index = index ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'salomon_bottom_bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        bottomNavigationBar:SalomonBottomBar(
          currentIndex:widget.index,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            SalomonBottomBarItem(

              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: mainDarkBlueColor,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor:mainDarkBlueColor,
            ),

            /// new
            SalomonBottomBarItem(
              icon: Icon(Icons.whatshot),
              title: Text("New Tweet"),
              selectedColor:mainDarkBlueColor,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor:mainDarkBlueColor,
            ),
          ],
        ),
        body:pages[widget.index],
        ),
    );
  }
}

