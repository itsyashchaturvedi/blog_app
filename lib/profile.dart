import 'package:blog_app/dataSecurity.dart';
import 'package:blog_app/downloads.dart';
import 'package:blog_app/info.dart';
import 'package:blog_app/settings.dart';
import 'package:blog_app/user_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  String uid;
  bool isfb;
  bool isSignin;
  Profile({this.isfb = false, required this.isSignin, this.uid = "", super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double bHeight = 280;
  Map<String, dynamic>? fb;
  bool isLoading=false;
  Future<void> getFacebook() async {
    try {
      final userData = await FacebookAuth.i.getUserData(fields: "email,name,picture.width(200)");
      setState(() {
        fb = userData;
        isLoading=false;
      });
    } catch (e) {
      print("Error fetching Facebook data: $e");
    }
  }

  @override
  void initState() {
    isfire=true;
    if (widget.isfb) {
      isLoading=true;
      getFacebook();
    }
    else
      {
        scanFirebase();
      }
    super.initState();
  }
  late Map<String,dynamic> firebase;
  late bool isfire;
  void scanFirebase() async {
    var fire= await FirebaseFirestore.instance.collection("Users").doc("${widget.uid}").get();
    setState(() {
      firebase=fire.data() as Map<String, dynamic>;
      isfire=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading || isfire?const Center(child: CircularProgressIndicator(color: Colors.greenAccent,),):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 550),
                width: MediaQuery.of(context).size.width,
                height: bHeight,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.greenAccent,
                      Colors.green,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 170, 20, 27.5),
                child: SizedBox(
                  height: 155,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Hero(
                    tag: 'info',
                    child: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: widget.isfb ? Image.network(
                          fb?['picture']['data']['url'] ,
                          fit: BoxFit.fill,
                          width: 150,
                        )
                            :
                          widget.isSignin?
                           Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL ??
                              "https://cdn-icons-png.flaticon.com/512/21/21104.png",
                          fit: BoxFit.fill,
                          width: 150,
                        ):
                          Image.network(
                            firebase.containsKey("profilePicture")?
                            firebase["profilePicture"]
                            :
                            "https://cdn-icons-png.flaticon.com/512/21/21104.png",
                            fit: BoxFit.cover,
                            width: 156.5,
                            height: 270,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35),
              highlightColor: Colors.greenAccent,
              splashColor: Colors.transparent,
              onTap: () {
                print(widget.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Info(isfb: widget.isfb,isSignin: widget.isSignin, name: "", uid: widget.uid),
                  ),
                );
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(FontAwesomeIcons.user, color: Colors.green),
                    ),
                    Text(
                      "Profile & Information",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 12, 0),
                      child: FaIcon(
                        Icons.chevron_right,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          Center(
            child: InkWell(
              highlightColor: Colors.greenAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataSecurity(isSignin: widget.isSignin,isfb: widget.isfb,uid: widget.uid),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(35),
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(Icons.security, color: Colors.green),
                    ),
                    Text(
                      "Data Privacy and Security",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 12, 0),
                      child: FaIcon(
                        Icons.chevron_right,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35.0),
              highlightColor: Colors.greenAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Downloads()),
                );
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: Icon(Icons.download, color: Colors.green),
                    ),
                    Text(
                      "Downloads",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35.0),
              highlightColor: Colors.greenAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserPost()),
                );
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: Icon(Icons.post_add_sharp, color: Colors.green),
                    ),
                    Text(
                      "Posts",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Setting()),
                );
              },
              borderRadius: BorderRadius.circular(35),
              highlightColor: Colors.greenAccent,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(Icons.settings, color: Colors.green),
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 12, 0),
                      child: FaIcon(
                        Icons.chevron_right,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
