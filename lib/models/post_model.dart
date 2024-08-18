class PostModel{
  String imgUrl;
  String title;
  String desc;
  DateTime dateTime;

  PostModel({required this.imgUrl,
    required this.title,
    required this.desc,
    required this.dateTime});

  Map<String, dynamic> toJson() => {
    "imgUrl": imgUrl,
    "title": title,
    "desc": desc,
    "date": dateTime,
  };

}