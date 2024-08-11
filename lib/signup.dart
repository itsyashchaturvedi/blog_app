import 'package:blog_app/colorpack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignuppageState();
}

class _SignuppageState extends State<SignupPage> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final boxwidth=MediaQuery.of(context).size.width*0.2;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 40, color: AppColors.textcolor),
              ),
              const SizedBox(height: 30),
              Text(
                "Name",
                style: TextStyle(color: AppColors.textcolor),
              ),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                decoration: InputDecoration(
                  hintText: "Youe Name",
                  hintStyle: TextStyle(color: AppColors.hitcolor),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Phone",
                style: TextStyle(color: AppColors.textcolor),
              ),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                decoration: InputDecoration(
                  hintText: "Youe Number",
                  hintStyle: TextStyle(color: AppColors.hitcolor),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Email",
                style: TextStyle(color: AppColors.textcolor),
              ),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  hintStyle: TextStyle(color: AppColors.hitcolor),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text("Password", style: TextStyle(color: AppColors.textcolor)),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                decoration: InputDecoration(
                  hintText: "Your Password",
                  hintStyle: TextStyle(color: AppColors.hitcolor),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: _isHovering ? Colors.blue : AppColors.textcolor,
                        decoration: TextDecoration.underline,decorationColor: AppColors.textcolor
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: screenWidth*10,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                        onPressed: (){}, child: Text("Create Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))),
              ),
              SizedBox(height: 70,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.hitcolor,
                      thickness: 3,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("or continue with",style: TextStyle(color: AppColors.textcolor),),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Divider(
                      color: AppColors.hitcolor,
                      thickness: 3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: boxwidth,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.textcolor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.google,color: Colors.black,size: 40,)),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: boxwidth,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.textcolor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.facebook,color: Colors.black,size: 40,)),

                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: boxwidth,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.textcolor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.apple,color: Colors.black,size: 40,)),

                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}