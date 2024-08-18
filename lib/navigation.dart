import 'package:blog_app/homepage.dart';
import 'package:blog_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'add.dart';
import 'blog_view.dart';

class Navigation extends StatefulWidget {
  final bool isTrue;
<<<<<<< HEAD
  final String image;
  String title;
  String desc;
  String author;
  Navigation({super.key,this.isTrue=false,this.image="",this.title="",this.desc="",this.author=""});
=======

  const Navigation({super.key,this.isTrue=false});
>>>>>>> e844433fbc0281b0e26edda5c1830796f85050fb

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Color home=Colors.white;
  Color add=Colors.white;
  Color person=Colors.white;
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
<<<<<<< HEAD
        screens[0]= BlogView(imgUrl: widget.image.toString().substring(0).replaceAll("//www", "https://www"),author: widget.author,desc: widget.desc,title: widget.title,);
=======
        screens[0]=const BlogView();
>>>>>>> e844433fbc0281b0e26edda5c1830796f85050fb
      }
  }
  final items= [
     const Icon(Icons.home,color: Colors.greenAccent,size: 32,),
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
              if(index==0){
                items[0]=const Icon(Icons.home,color: Colors.greenAccent,size: 32,);
                items[1]=const Icon(Icons.add,color: Colors.white,size: 25,);
                items[2]=const Icon(Icons.person,color: Colors.white,size: 25,);
              }
              if(index==1){
                items[0]= const Icon(Icons.home,color: Colors.white,size: 25,);
                items[1]=const Icon(Icons.add,color: Colors.greenAccent,size: 32,);
                items[2]=const Icon(Icons.person,color: Colors.white,size: 25,);
              }
              if(index==2){
                items[0]=const Icon(Icons.home,color: Colors.white,size: 25,);
                items[1]=const Icon(Icons.add,color: Colors.white,size: 25,);
                items[2]=const Icon(Icons.person,color: Colors.greenAccent,size: 32,);
              }
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