import 'package:blog_app/forgotpass.dart';
import 'package:blog_app/homepage.dart';
import 'package:blog_app/navigation.dart';
import 'package:blog_app/signup.dart';
import 'package:blog_app/colorpack.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
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
                "Log In",
                style: TextStyle(fontSize: 40, color: AppColors.textcolor),
              ),
              const SizedBox(height: 30),
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
                  },
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
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
                        onPressed: ()
                        {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Navigation()));
                        }, child: Text("Continue",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))),
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
              SizedBox(height:MediaQuery.of(context).size.height*0.10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?",style: TextStyle(color: AppColors.textcolor),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                  }, child: Text("Sign up",style: TextStyle(color: Color.fromARGB(255, 80, 235, 14)),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}