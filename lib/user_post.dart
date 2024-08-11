import 'package:flutter/material.dart';
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
    );
  }
}
