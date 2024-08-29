import 'package:blog_app/homepage.dart';
import 'package:blog_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'add.dart';
import 'blog_view.dart';

class Navigation extends StatefulWidget {
  final bool isTrue;
  String uid;
  final bool isSignin;
  final bool isfb;
  final String image;
  final String title;
  final String desc;
  final String author;

  Navigation({
    super.key,
    this.isfb=false,
    this.isTrue = false,
    this.image = "",
    this.title = "",
    this.desc = "",
    this.author = "",
    this.uid="",
    this.isSignin=false
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Color home = Colors.white;
  Color add = Colors.white;
  Color person = Colors.white;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    if (widget.isTrue) {
      screens = [
        BlogView(
          imgUrl: widget.image,
          desc: widget.desc,
          title: widget.title, 
        ),
        const Add(),
        Profile(uid: widget.uid,isSignin: widget.isSignin,isfb: widget.isfb,),
      ];
    }
    else {
      screens = [
        const BlogHomePage(),
        const Add(),
        Profile(uid: widget.uid,isSignin: widget.isSignin,isfb: widget.isfb,),
      ];
    }
  }

  final items = [
    const Icon(Icons.home, color: Colors.white, size: 32),
    const Icon(Icons.add, color: Colors.white, size: 25),
    const Icon(Icons.person, color: Colors.white, size: 25),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.decelerate,
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        color: Colors.white12,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        buttonBackgroundColor: Colors.white12,
        backgroundColor: Colors.black12,
        items: [
          Icon(Icons.home,
              color: currentIndex == 0 ? Colors.greenAccent : Colors.white,
              size: 32),
          Icon(Icons.add,
              color: currentIndex == 1 ? Colors.greenAccent : Colors.white,
              size: 32),
          Icon(Icons.person,
              color: currentIndex == 2 ? Colors.greenAccent : Colors.white,
              size: 32),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
