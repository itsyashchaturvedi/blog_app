import 'dart:io';

import 'package:blog_app/changes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Info extends StatefulWidget {
  String name;
  Info({super.key,required this.name});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool isDone=false;
  dynamic settingImage;
  void getImage()async {
    Get.bottomSheet(
        Container(
          width: MediaQuery.of(context).size.width-8,
          height: 280,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.circular(50)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Add Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),
              Padding(
                padding: const EdgeInsets.all(55.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(onPressed: () async {
                          XFile? image=await ImagePicker().pickImage(source: ImageSource.camera);
                          setState(() {
                            isDone=true;
                            settingImage=File(image!.path);
                            Navigator.pop(context);
                          });
                        },icon:const Icon(Icons.camera ,size: 80,)),
                        const Text("Camera",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    const SizedBox(width: 90,),
                    Column(
                      children: [
                        IconButton(onPressed: () async
                        {
                          XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery);
                          setState(() {
                            isDone=true;
                            settingImage=File(image!.path);
                            Navigator.pop(context);
                          });
                        },
                            icon:const Icon(Icons.image ,size: 80,)),
                        const Text("Gallery",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,),
        ),
        backgroundColor: Colors.black,
        title: const Text("Profile & Information",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                  colors: <Color>[
                    Colors.greenAccent,
                    Colors.green,
                  ]
              )
            ),
            child:  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Padding(
                    padding: const EdgeInsets.only(top: 60,bottom: 15),
                     child: Center(
                       child: Hero(tag: 'info',
                           child:
                                Stack(
                                  children :[
                                    CircleAvatar(
                                      backgroundColor: isDone?Colors.transparent:Colors.white,
                                    radius: 65,
                                    child: isDone? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        settingImage,
                                        fit: BoxFit.cover,width: 150,height: 250,),
                                    ):ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                          FirebaseAuth.instance.currentUser!.photoURL??
                                          "https://cdn-icons-png.flaticon.com/512/21/21104.png",
                                        fit: BoxFit.cover,width: 150,height: 270,),
                                    ),
                                  ),
                                  Positioned(left: 90,top: 85,child: CircleAvatar(
                                    backgroundColor: Colors.indigo,
                                    child: IconButton(onPressed: (){
                                    getImage();
                                    },
                                    icon: const Icon(Icons.add_a_photo_outlined,color: Colors.white,),),
                                  ))
                                  ]),

                     ),
                   ),
                    ),
                  Text(FirebaseAuth.instance.currentUser!.displayName??widget.name,style: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),),

                  const SizedBox(height: 30,),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(17, 0, 17, 30),
                    child: Center(child: Text("App uses this information to verify your identity and to keep our community safe. You decide what personal details you make visible")),
                  ),
                  Center(
                    child: Container(
                      height: 212.2,
                       width: MediaQuery.of(context).size.width-35,
                       decoration: BoxDecoration(
                         border: Border.all(
                           color: Colors.black
                         ),
                         borderRadius: BorderRadius.circular(25)
                       ),
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(changes: "Yash Chaturvedi", type: "Name")));
                                },
                                child: const Row(
                                  children: [
                                    Text("Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                    Expanded(child: SizedBox()),
                                    Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(dob: "2024-01-27",dateInfo: true,changes: "", type: "Date of Birth")));
                                },
                                child:const Row(
                                  children: [
                                    Text("Date of Birth",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                    Expanded(child: SizedBox()),
                                    Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(numKeyboard: true,changes: "7900205204", type: "Contact Info")));
                                },
                                child:const Row(
                                  children: [
                                    Text("Contact Info",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                    Expanded(child: SizedBox()),
                                    Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                    ),
                  )
                ],
              ),
            ),
          ),

      ),
    );
  }
}