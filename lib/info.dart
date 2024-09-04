import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog_app/changes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Info extends StatefulWidget {
  String name;
  bool isSignin;
  bool isfb;
  String uid;
  Info({this.isfb=false,super.key,this.uid="",required this.name,required this.isSignin});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late bool isDone;
  late bool isYes;
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
                          },
                            icon:const Icon(Icons.camera ,size: 80,)),
                        const Text("Camera",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      children: [
                        IconButton(onPressed: () async
                        {
                          XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery);
                          setState(() {
                            isDone=true;
                            settingImage=image;
                          });
                          uploadImage();
                          Navigator.pop(context);
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
  Future<void> uploadImage()async{
    final image=File(settingImage!.path);
    final path1="profile/${DateTime.now().toString()}";
    final ref=FirebaseStorage.instance.ref().child(path1);
    final upload=ref.putFile(image);
    TaskSnapshot snapshot=await upload.whenComplete(() {});
    final downloadUrl=await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("Users").doc("${widget.uid}").update({"profilePicture": "${downloadUrl}"});
  }
  late DocumentSnapshot name;
   late final fb;
  Future<void> getFacebook()async{
    final userdata=await FacebookAuth.i.getUserData(fields: "name,email,picture.width(200)");
  setState(() {
    fb= userdata;
    isYes=false;
  });

  }
  void getName() async {
    name=await FirebaseFirestore.instance.collection("Users").doc("${widget.uid}").get();
    setState(() {
      isYes=false;
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isfb) {
      getFacebook();
      isYes=true;
    }
    else {
      if (widget.isSignin) {
        isYes = false;
      }
      else {
        isYes = true;
        scanFirebase();
        isDone=true;
        isfire=true;
      }
      getName();
    }
  }
  @override
  Widget build(BuildContext context) {
    return isYes || isfire?const Center(child: CircularProgressIndicator(color: Colors.greenAccent,),) :Scaffold(
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
                       child: Hero(
                         tag: 'info',
                           child:
                                Stack(
                                  children :[
                                    CircleAvatar(
                                      backgroundColor: isDone?Colors.transparent:Colors.white,
                                    radius: 65,
                                    child: isDone? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:  Image.network(
                                        firebase.containsKey("profilePicture")?
                                        firebase["profilePicture"]
                                            :
                                        "https://cdn-icons-png.flaticon.com/512/21/21104.png",
                                        fit: BoxFit.cover,width: 150,height: 250,),
                                     )
                                        :
                                     ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: widget.isSignin?
                                      widget.isfb?
                                      Image.network(
                                        fb['picture']['data']['url'],
                                        fit: BoxFit.cover,width: 150,height: 270,)
                                          :
                                      Image.network(
                                          FirebaseAuth.instance.currentUser?.photoURL??"",
                                        fit: BoxFit.cover,width: 150,height: 270,):
                                      Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/21/21104.png",
                                        fit: BoxFit.cover,width: 150,height: 270,),
                                    ),
                                  ),
                                  Positioned(left: 90,top: 85,child: widget.isSignin?const SizedBox(): CircleAvatar(
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

                  widget.isSignin?widget.isfb?
                  Text(fb['name'],style: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),)
                      :
                  Text(FirebaseAuth.instance.currentUser!.displayName??"",style: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),)
                  :
                  Text(name["name"].toString(),style: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600),),
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
                                  widget.isSignin?
                                      widget.isfb?
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: fb['name'], type: "Name")))
                                          :
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: FirebaseAuth.instance.currentUser?.displayName??"", type: "Name")))
                                      :
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: name["name"], type: "Name")));
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,dob: "2024-01-27",dateInfo: true,changes: "", type: "Date of Birth")));
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
                                  widget.isSignin?widget.isfb?
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,numKeyboard: true,changes: "No data due to security concern", type: "Contact Info")))
                                  :
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,numKeyboard: true,changes: "No data due to security concern", type: "Contact Info")))
                                  :
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,numKeyboard: true,changes: name["phoneNumber"].toString(), type: "Contact Info")));
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