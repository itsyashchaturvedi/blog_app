import 'dart:convert';

import 'package:blog_app/blog_view.dart';
import 'package:blog_app/blogitem.dart';
import 'package:blog_app/category.dart';
import 'package:blog_app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'models/blog_model.dart';
import 'models/fetch_blog.dart';

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  State<BlogHomePage> createState() => _BloghomePageState();
}

class _BloghomePageState extends State<BlogHomePage> {

  final List<Map<String, String>> posts = [
    {
      'title': 'Surfing Adventures',
      'date': 'Aug 25, 2024',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Exploring the Oceans',
      'date': 'Aug 20, 2024',
      'image': 'https://via.placeholder.com/150',
    },

    {
      'title': 'Surfing Adventures',
      'date': 'Aug 25, 2024',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Exploring the Oceans',
      'date': 'Aug 20, 2024',
      'image': 'https://via.placeholder.com/150',
    },
  ];
  late FetchBlog fetchBlog;
  late bool isTrue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTrue=true;
    get();
  }
  Future<void> get()async{
    fetchBlog= await BlogModel.fetchBlogs();
    print(fetchBlog.title);
    setState(() {
      isTrue=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "SYLLEX",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  fillColor: Color.fromARGB(115, 91, 84, 84),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Color.fromARGB(221, 102, 93, 93)),
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
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
              isTrue?Center(child: CircularProgressIndicator(),):
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Navigation(isTrue: true,image: fetchBlog.imgUrl,author: fetchBlog.author,title: fetchBlog.title,desc: fetchBlog.desc,)));
                },
                child: BlogItem(isFullWidth: false,
                      imageUrl:fetchBlog.imgUrl ,
                      title: "" ,
                      date: ""),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
