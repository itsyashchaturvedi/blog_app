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
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView>{
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
                          Image.network('https://www.nebulainfotech.com/blog/wp-content/uploads/2023/01/How-to-use-AI-for-Blogging-That-Rank-High-on-Google.jpg',fit: BoxFit.cover,)),

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
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 2, 0),
                child: Text("Let’s Talk About Emergence",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("By Jacob Haimes | June 24,2024",style: TextStyle(color: Colors.green,fontSize: 17.5),)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(7, 12, 0, 7),
                child: Center(
                  child: Text("The field of machine learning has existed for many decades, but only recently have governments become actively concerned about the technologies leveraging its most advanced techniques. For a majority of people, this can be traced to the launch of ChatGPT, when we entered an era of so-called Large Language Models, or LLMs. One reasonable question, then, is what made ChatGPT dissimilar to its predecessors?"
                  "One distinction that has been proposed as a key differentiation between LLMs, and their smaller counterpart, Language Models, is that LLMs exhibit Emergence, or equivalently, that some of their capabilities have been categorized as Emergent. It is important to note that, in this context, the root Emerge is being used as a keyword specific to the domain of machine learning, and not for its other definitions. Although the nuances of the definition differ between publications, the root Emerge is frequently reduced to some variation of the definition given by Wei et al.: “An ability is mergent if it is not present in smaller models but is present in larger models.” Although this meaning does result in circular reasoning when taken in conjunction with the description of LLMs proposed by domain experts in “Large Language Models: A Survey,” it is the one that has been largely accepted within machine learning circles, so we will use it as the basis for our understanding within this article]. The term’s meaning, as a keyword in the field of machine learning, is obfuscated by a number of factors, which we will explore in this article."
                  "Emergence has been referenced in many works as a salient threat vector that could cause significant harm if ignored; a prominent paper from titled “Open Sourcing Highly Capable Foundation Models: An evaluation of risks, benefits, and alternative methods for pursuing open-source objectives” highlighted Emergence as a reason to refrain from Open Source practices, and a relatively recent paper titled “Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training” recognized Emergent deception as a threat vector salient enough to warrant a massive research effort and modification of current state-of-the-art technique. Perhaps most crucially, policymakers are beginning to cite Emergence as a motivating factor as well, as is seen in a letter from the House Committee on Science, Space, and Technology to the director of the National Institute of Standards and Technology.",
                    style: TextStyle(color: Colors.white,fontSize: 15),),
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
