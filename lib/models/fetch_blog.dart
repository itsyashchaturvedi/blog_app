class FetchBlog
{
  String imgUrl;
  String title;
  String desc;
  String author;
  FetchBlog({
    required this.imgUrl,
    required this.title,
    required this.desc,
    required this.author});

  static Future<FetchBlog> getBlog(Map<dynamic,dynamic> blog)
  async {
    return FetchBlog(
        imgUrl: blog['author']['image']['url'],
        title: blog['title'],
        desc: blog['content'],
        author: blog['author']['displayName']
    );
  }
}