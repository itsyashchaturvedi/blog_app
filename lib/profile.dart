import 'package:blog_app/dataSecurity.dart';
import 'package:blog_app/downloads.dart';
import 'package:blog_app/info.dart';
import 'package:blog_app/settings.dart';
import 'package:blog_app/user_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double bHeight=280;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children:[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 550),
                width: MediaQuery.of(context).size.width,
                height: bHeight,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(200),bottomLeft: Radius.circular(200)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.purpleAccent,
                      Colors.deepPurpleAccent,
                    ]
                  )
                ),
                            ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 170, 20, 27.5),
                child: SizedBox(
                  height: 155,
                  width: MediaQuery.of(context).size.width-40,
                  child:  Hero(
                    tag: 'info',
                    child: CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL
                              ??
                              "https://cdn-icons-png.flaticon.com/512/21/21104.png",fit: BoxFit.fill,width: 150,),
                      ),

                    ),
                  ),
                ),
              ),
            ]
          ),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35),
              highlightColor: Colors.purpleAccent,
              splashColor: Colors.transparent,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Info(name: "Yash Chaturvedi",)));
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width-20,
                decoration:BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                  ),
                  borderRadius: BorderRadius.circular(35)
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(FontAwesomeIcons.user,color: Colors.deepPurpleAccent,),
                    ),
                    Text("Profile & Information",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(5, 0, 12, 0),
                      child: Icon(Icons.chevron_right,color: Colors.deepPurpleAccent,size: 35,)
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27,),
          Center(
            child: InkWell(
              highlightColor: Colors.purpleAccent,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const DataSecurity()));
              },
              borderRadius: BorderRadius.circular(35),
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width-20,
                decoration:BoxDecoration(
                  border: Border.all(
                    color: Colors.purple
                  ),
                  borderRadius: BorderRadius.circular(35)
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(Icons.security,color: Colors.deepPurpleAccent,),
                    ),
                    const Text("Data Privacy and Security",style: TextStyle(color: Colors.white,fontSize: 20,),),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(33, 0, 0, 0),
                        child: IconButton(onPressed: (){},icon:const FaIcon(Icons.chevron_right,color: Colors.deepPurpleAccent,size: 35,),)
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27,),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35.0),
              highlightColor: Colors.purpleAccent,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Downloads()));
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width-20,
                decoration:BoxDecoration(
                  border: Border.all(
                    color: Colors.purple
                  ),
                  borderRadius: BorderRadius.circular(35)
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: Icon(Icons.download,color: Colors.deepPurpleAccent,),
                    ),
                    Text("Downloads",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27,),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(35.0),
              highlightColor: Colors.purpleAccent,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserPost()));
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width-20,
                decoration:BoxDecoration(
                    border: Border.all(
                        color: Colors.purple
                    ),
                    borderRadius: BorderRadius.circular(35)
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: Icon(Icons.post_add_sharp,color: Colors.deepPurpleAccent,),
                    ),
                    Text("Posts",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 27,),
          Center(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
              },
              borderRadius: BorderRadius.circular(35),
              highlightColor: Colors.purpleAccent,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width-20,
                decoration:BoxDecoration(
                  border: Border.all(
                    color: Colors.purple
                  ),
                  borderRadius: BorderRadius.circular(35)
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.fromLTRB(12, 0, 24.5, 0),
                      child: FaIcon(Icons.settings,color: Colors.deepPurpleAccent,),
                    ),
                    const Text("Settings",style: TextStyle(color: Colors.white,fontSize: 20),),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 12, 0),
                      child: IconButton(onPressed: (){},icon:FaIcon(Icons.chevron_right,color: Colors.deepPurpleAccent,size: 35,),)
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
