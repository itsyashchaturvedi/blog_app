import 'dart:ui';
import 'package:blog_app/blogitem.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog_app/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlogView extends StatefulWidget {
  String imgUrl;
  String title;
  String desc;
  String author;
  BlogView({super.key,this.imgUrl="",this.title="",this.desc="",this.author=""});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView>{
  late String finalDesc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalDesc=removeHtmlTags(widget.desc);
  }

  String removeHtmlTags(String htmlString) {
    // Regular expression to match HTML tags
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    // Replace HTML tags with an empty string
    String cleanedString = htmlString.replaceAll(exp, '');

    return cleanedString;
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text("Syllex",style: TextStyle(color: Colors.white),),
      ),
      body:
      Padding(
        padding: const EdgeInsets.only(bottom: 16.8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children:[
                    Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(17.0),
                          bottomRight: Radius.circular(17.0))
                    ),
                    width: MediaQuery.of(context).size.width-3.5,
                    height:500,
                    child: ClipRRect(borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(17.0),
                          bottomRight: Radius.circular(17.0)),
                          child:
                          Image.network(widget.imgUrl,fit: BoxFit.cover,)),

                  ),
                    IconButton(
                        onPressed: (){
                            Fluttertoast.showToast(msg: "Downloading",
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.green,
                            );
                    },
                        icon: const FaIcon(FontAwesomeIcons.download,color: Colors.white,))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 2, 0),
                child: Text(widget.title,style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${widget.author} | June 24,2024",style:const TextStyle(color: Colors.green,fontSize: 17.5),)
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(7, 12, 0, 7),
                child: Center(
                  child: Text(finalDesc.trimLeft().trimRight().trim(),
                    style: const TextStyle(color: Colors.white,fontSize: 15),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width-7,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                        child: FaIcon(FontAwesomeIcons.comment,color: Colors.white,),
                      ),
                      const Text("Show Comments",style: TextStyle(color: Colors.white,fontSize: 19.5),),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(onPressed: (){},icon: const FaIcon(FontAwesomeIcons.arrowRight,color: Colors.white,),),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 20),
                child: Text("Related Posts",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(child: BlogItem(isFullWidth: false, isFullShade: false, imageUrl: '', title: '', date: '',)),
                    const SizedBox(width: 10),
                    Expanded(child: BlogItem(isFullWidth: false, isFullShade: false, imageUrl: '', date: '', title: '',)),
                  ],
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
