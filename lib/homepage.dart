import 'package:blog_app/blog_view.dart';
import 'package:blog_app/blogitem.dart';
import 'package:blog_app/category.dart';
import 'package:blog_app/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  State<BlogHomePage> createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("SYLLEX",style: TextStyle(fontFamily: 'Gupter',color: Colors.white,fontSize: 25),)),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    fillColor: Color.fromARGB(115, 91, 84, 84),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Color.fromARGB(221, 102, 93, 93)),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35)
                    )
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryIcon(Icons.surfing, 'Surfing'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sailing, 'Sailing'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sports_basketball, 'Basketball'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sports_tennis, 'Tennis'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.directions_bike, 'Cycling'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.hiking, 'Hiking'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.run_circle, 'Running'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sports_soccer, 'Soccer'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sports_cricket, 'Cricket'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.sports_golf, 'Golf'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.fitness_center, 'Fitness'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.restaurant, 'Food'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.flight, 'Travel'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.camera_alt, 'Photography'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.palette, 'Art'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.book, 'Books'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.movie, 'Movies'),
                    const SizedBox(width: 10,),
                    CategoryIcon(Icons.music_note, 'Music'),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlogItem(isFullWidth: false, isFullShade: false),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: InkWell(
                              child: BlogItem(isFullWidth: false, isFullShade: false),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Navigation(isTrue: true,)));
                              },
                          ),),

                          const SizedBox(width: 10),
                          Expanded(child: BlogItem(isFullWidth: false, isFullShade: false)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      BlogItem(isFullWidth: true, isFullShade: false, isLastItem: true),
                    ],
                  ),
                ),)
            ],
          ),
        ),),
    );
  }
}