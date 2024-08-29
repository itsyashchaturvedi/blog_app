import 'package:blog_app/accounts_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'changes.dart';

class DataSecurity extends StatefulWidget {
  String uid;
  bool isSignin;
  bool isfb;
  DataSecurity({this.isfb=false,this.isSignin=false,this.uid="",super.key});

  @override
  State<DataSecurity> createState() => _DataSecurityState();
}

class _DataSecurityState extends State<DataSecurity> {
  late DocumentSnapshot name;
  late bool isYes;
  late final fb;
  void getName()async{
    name=await FirebaseFirestore.instance.collection("Users").doc("${widget.uid}").get();
    setState(() {
      isYes=false;
    });
  }
  void getFacebook() async{
    final facebook=await FacebookAuth.i.getUserData(fields: "email");
    setState(() {
      fb=facebook;
      isYes=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isYes=true;
    if(widget.isfb){
      getFacebook();
    }
    else if(widget.isfb!=true){
      isYes=false;
    }
    getName();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Data Privacy and Security",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,),
        ),
      ),
      body: isYes?const Center(child: CircularProgressIndicator(color: Colors.greenAccent,),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
                colors: <Color>[
                  Colors.greenAccent,
                  Colors.green,
                ]
            )
          ),
          child: Column(
            children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 40, 15,35),
                  child: Text("Your security is our top most priority. We are committed to protecting your personal information and providing a secure experience while using our applications.",style: TextStyle(fontSize: 15),),
                ),
              Center(
                child: Container(
                  height: 150,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: fb["email"], type: "Email")))
                            :
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: FirebaseAuth.instance.currentUser?.email??"No data Provided", type: "Email")))
                            :
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(uid: widget.uid,changes: name["email"].toString(), type: "Email")));
                          },
                          child:const Row(
                            children: [
                              Text("Email",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
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
                            widget.isSignin?
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: "No data due to Security Concern", type: "Password")))
                            :
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(isSignin: widget.isSignin,uid: widget.uid,changes: "${name["password"].toString().substring(0,3)}XXXXXXXX", type: "Password")));
                          },
                          child:const Row(
                            children: [
                              Text("Password",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                              Expanded(child: SizedBox()),
                              Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 62.3, 50, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-30,
                  height: 68,
                  child: Row(
                    children: [
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountsView(url: "https://myaccount.google.com/",name: "Google",)));
                      },
                          child: CircleAvatar(radius: 50,child: Image.asset("Assets/google.png",scale: 8,),)),
                      const SizedBox(width: 100,),
                      InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountsView(url: "https://www.facebook.com",name: "Facebook",)));
                          },
                          child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset("Assets/facebook.png")))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
