import 'package:blog_app/homepage.dart';
import 'package:blog_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'add.dart';
import 'blog_view.dart';

class Navigation extends StatefulWidget {
  bool isTrue;
  Navigation({super.key,this.isTrue=false});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List screens=[
    BlogHomePage(),
    Add(),
    Profile()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isTrue==true)
      {
        screens[0]=BlogView();
      }
  }
  final items=   [
    const Icon(Icons.home,color: Colors.white,size: 25,),
    const Icon(Icons.add,color: Colors.white,size: 25,),
    const Icon(Icons.person,color: Colors.white,size: 25,)
  ];
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar (
          animationCurve: Curves.decelerate,
          animationDuration: const Duration(milliseconds: 300),
          height: 60,
          color: Colors.white12,
          onTap: (index){
            setState(() {
              currentIndex=index;
            });
          },
          buttonBackgroundColor: Colors.white12,
          backgroundColor: Colors.black12,
          items: items
      ),
      body: screens[currentIndex],
    );
  }
}
