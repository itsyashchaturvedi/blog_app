class BlogPostModel {
  final String title;
  final String desc;
  final String imgUrl;

  BlogPostModel({
    required this.title,
    required this.desc,
    required this.imgUrl,
  });

  factory BlogPostModel.fromMap(Map<String, dynamic> data) {
    return BlogPostModel(
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
      imgUrl: data['imgUrl'] ?? '',
    );
  }
}
