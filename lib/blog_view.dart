import 'package:blog_app/controller/controller.dart';
import 'package:blog_app/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blog_app/homepage.dart';
import 'package:blog_app/controller/blogprovider.dart';
import 'package:blog_app/blogitem.dart';
import 'package:blog_app/models/blogpost_model.dart';


class BlogView extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String authorId; // Changed to authorId
  final String postId;

  const BlogView({
    Key? key,
    this.imgUrl = "",
    this.title = "",
    this.desc = "",
    this.authorId = "", // Initialize authorId
    this.postId = "",
  }) : super(key: key);

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  late String finalDesc;
  List<BlogPostModel> relatedPosts = [];
  String authorName = "";

  @override
  void initState() {
    super.initState();
    finalDesc = removeHtmlTags(widget.desc);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<BlogPost>(context, listen: false).getPost();
        setState(() {
          relatedPosts = Provider.of<BlogPost>(context, listen: false).postList;
        });

        // Fetch the author's name
        Databasemethod db = Databasemethod();
        UserModel? user = await db.getUser(widget.authorId);
        if (user != null) {
          setState(() {
            authorName = user.name;
          });
        }
      } catch (e) {
        print("Error fetching posts or user: $e");
      }
    });
  }

  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text("Syllex", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(17.0),
                          bottomRight: Radius.circular(17.0),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 3.5,
                      height: 500,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(17.0),
                          bottomRight: Radius.circular(17.0),
                        ),
                        child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "Downloading",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.green,
                          );

                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 2, 0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$authorName | June 24, 2024", // Display the fetched author's name
                      style: const TextStyle(color: Colors.green, fontSize: 17.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 12, 0, 7),
                child: Center(
                  child: Text(
                    finalDesc.trim(),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 7,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: Icon(Icons.comment, color: Colors.white),
                      ),
                      const Text("Show Comments", style: TextStyle(color: Colors.white, fontSize: 19.5)),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 20),
                child: Text(
                  "Related Posts",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: relatedPosts.map((post) => BlogItem(
                    isFullWidth: false,
                    isFullShade: false,
                    imageUrl: post.imgUrl,
                    title: post.title,
                  )).toList(),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
