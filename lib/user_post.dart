import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/blogprovider.dart'; // Import your provider
import 'blogitem.dart';
import 'navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPost extends StatefulWidget {
  const UserPost({super.key});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,),),
        title: const Text("Posts",style: TextStyle(color: Colors.white),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(11.0),
        child: Container(
          child: _buildBlogPostsList(context),
        ),
      ) ,
    );
  }
}
Widget _buildBlogPostsList(BuildContext context) {
  return Expanded(
    child: FutureBuilder(
      future: Provider.of<BlogPost>(context, listen: false).getPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.greenAccent,));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading posts: ${snapshot.error}",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final blogPostProvider = Provider.of<BlogPost>(context);
        if (blogPostProvider.postList == null || blogPostProvider.postList.isEmpty) {
          return Center(
            child: Text(
              "No posts available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return GridView.builder(
          itemCount: blogPostProvider.postList.length-4,
          itemBuilder: (context, index) {
            final post = blogPostProvider.postList[index];
            return Column(
              children: [
                InkWell(
                  child: BlogItem(
                    isFullWidth: false,
                    isFullShade: false,
                    imageUrl: post.imgUrl ?? 'https://default-image-url.com',
                    title: post.title ?? 'No Title',
                  ),
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Navigation(
                            isTrue: true,
                            image: post.imgUrl,
                            title: post.title,
                            desc: post.desc,
                          ),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 12.0,crossAxisSpacing: 12.0),
        );
      },
    ),
  );
}