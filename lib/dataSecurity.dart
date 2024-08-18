import 'package:blog_app/accounts_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'changes.dart';

class DataSecurity extends StatefulWidget {
  const DataSecurity({super.key});

  @override
  State<DataSecurity> createState() => _DataSecurityState();
}

class _DataSecurityState extends State<DataSecurity> {
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
      body: Padding(
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(changes: "yash@gmail.com", type: "Email")));
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Changes(changes: "72134", type: "Password")));
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
