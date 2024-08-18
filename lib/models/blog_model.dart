import 'dart:convert';
import 'package:blog_app/models/fetch_blog.dart';
import 'package:http/http.dart';

class BlogModel {
  static Future<FetchBlog> fetchBlogs() async {
    Response response = await get(Uri.parse(
        "https://www.googleapis.com/blogger/v3/blogs/2399953/posts?key=AIzaSyDCwfAS-UGvgFVruccGRTr86DlCVUcFc28"
    ));

    final items = json.decode(response.body);
    Map<String,dynamic> blogsList = items["items"][3];
    return FetchBlog.getBlog(blogsList);
  }
}
