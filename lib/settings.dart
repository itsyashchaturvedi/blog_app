import 'dart:ui';

import 'package:blog_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double opacity;
  late bool isTrue;
  late bool isSecond;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opacity=0.0;
    isTrue=false;
    isSecond=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: <Color>[
                  Colors.greenAccent,
                  Colors.green,
                ]
            ),
            borderRadius: BorderRadius.circular(50),
          ),
            child: Column(
              children: [
            Column(
            children: [
            const Padding(
            padding: EdgeInsets.fromLTRB(15, 40, 15,35),
          child: Text("Manage your Settings.Contact us from Help Center for any type of Assistance.",style: TextStyle(fontSize: 15),),
        ),
        Center(
          child: Container(
            height: 220,
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
                      if(isTrue==false || isSecond==true) {
                        setState(() {
                          isSecond=false;
                          opacity = 1.0;
                          isTrue=true;
                        });
                      }
                      else
                        {
                          setState(() {
                            isTrue=false;
                            opacity=0.0;
                          });
                        }
                     },
                    child:const Row(
                      children: [
                        Text("Help and Support",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        Expanded(child: SizedBox()),
                        Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: ()
                    {
                      if(isTrue==false || isSecond==false) {
                        setState(() {
                          opacity = 1.0;
                          isTrue=true;
                          isSecond=true;
                        });
                      }
                      else
                      {
                        setState(() {
                          opacity=0.0;
                          isTrue=false;
                        });
                      }
                    },
                    child:const Row(
                      children: [
                        Text("Privacy Policy",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
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
                      showDialog(context: context, builder:(context){
                        return
                          AlertDialog(
                            actionsPadding: const EdgeInsets.fromLTRB(10, 0, 30,0),
                            title: const Text("Log Out"),
                            content: const Text("Are you sure want to Log Out?"),
                            actions: [
                              TextButton(onPressed: (){
                                setState(() {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Loginpage()));
                                });
                              },
                                  child: const Text("Yes")),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("Cancel"))
                            ],
                            shadowColor: Colors.blue,
                          );

                      }
                      );
                    },
                    child:const Row(
                      children: [
                        Text("Log Out",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        Expanded(child: SizedBox()),
                        Icon(Icons.keyboard_arrow_right_outlined,size: 35,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )],
            ),
              AnimatedOpacity(curve: Curves.decelerate,duration: const Duration(milliseconds: 800),opacity: opacity,child: Padding(
                  padding:const EdgeInsets.all(15),
                  child: AnimatedCrossFade(
                      firstChild: RichText(
                      text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "For any type of Assistance or Help and Support, Feel Free to Contact:\f\f",style: TextStyle(fontSize: 16,color: Colors.black)),
                            TextSpan(text: "Y",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w700,color: Colors.indigo)),
                            TextSpan(text: "ash :- itsyashchaturvedi@gmail.com ",style: TextStyle(fontSize: 20,color: Colors.black)),
                            TextSpan(text: "C",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w700,color: Colors.indigo)),
                            TextSpan(text: "hitra :- chitrak1110@gmail.com",style: TextStyle(fontSize: 20,color: Colors.black))
                          ]
                      )), secondChild: RichText(
                      text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Privacy Policy\f",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w700,color: Colors.black)),
                            TextSpan(text: "We",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,color: Colors.indigo)),
                            TextSpan(text: " value your privacy. Our blog app collects minimal personal information, such as your email address and name, solely for account creation and login purposes. We do not share your information with third parties. Your data is securely stored and used only to enhance your experience with our app. For any concerns or inquiries, please contact us.",style: TextStyle(fontSize: 20,color: Colors.black)),
                          ]
                      )), crossFadeState:  isSecond?CrossFadeState.showSecond:CrossFadeState.showFirst, duration: const Duration(milliseconds: 500)))),
              ]),
      ),
    ));
  }
}
