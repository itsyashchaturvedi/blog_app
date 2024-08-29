import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/blogprovider.dart'; // Import your provider
import 'blogitem.dart';
import 'category.dart';
import 'navigation.dart';

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  State<BlogHomePage> createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "SYLLEX",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildCategoryIcons(),
                const SizedBox(height: 10),
                _buildBlogPostsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        fillColor: Color.fromARGB(115, 91, 84, 84),
        hintText: "Search",
        hintStyle: TextStyle(color: Color.fromARGB(221, 102, 93, 93)),
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCategoryIcons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:  [
          CategoryIcon(Icons.surfing, 'Surfing'),
          const SizedBox(width: 10),
          CategoryIcon(Icons.sailing, 'Sailing'),
          SizedBox(width: 10),
          CategoryIcon(Icons.sports_basketball, 'Basketball'),
          SizedBox(width: 10),
          CategoryIcon(Icons.sports_tennis, 'Tennis'),
          SizedBox(width: 10),
          CategoryIcon(Icons.directions_bike, 'Cycling'),
          SizedBox(width: 10),
          CategoryIcon(Icons.hiking, 'Hiking'),
          SizedBox(width: 10),
          CategoryIcon(Icons.run_circle, 'Running'),
          SizedBox(width: 10),
          CategoryIcon(Icons.sports_soccer, 'Soccer'),
          SizedBox(width: 10),
          CategoryIcon(Icons.sports_cricket, 'Cricket'),
          SizedBox(width: 10),
          CategoryIcon(Icons.sports_golf, 'Golf'),
          SizedBox(width: 10),
          CategoryIcon(Icons.fitness_center, 'Fitness'),
          SizedBox(width: 10),
          CategoryIcon(Icons.restaurant, 'Food'),
          SizedBox(width: 10),
          CategoryIcon(Icons.flight, 'Travel'),
          SizedBox(width: 10),
          CategoryIcon(Icons.camera_alt, 'Photography'),
          SizedBox(width: 10),
          CategoryIcon(Icons.palette, 'Art'),
          SizedBox(width: 10),
          CategoryIcon(Icons.book, 'Books'),
          SizedBox(width: 10),
          CategoryIcon(Icons.movie, 'Movies'),
          SizedBox(width: 10),
          CategoryIcon(Icons.music_note, 'Music'),
        ],
      ),
    );
  }

  Widget _buildBlogPostsList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: Provider.of<BlogPost>(context, listen: false).getPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
          return ListView.builder(
            itemCount: blogPostProvider.postList.length,
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
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
