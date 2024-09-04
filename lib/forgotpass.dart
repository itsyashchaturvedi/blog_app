import 'package:blog_app/colorpack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgcolor,
        foregroundColor: AppColors.textcolor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: AppColors.bgcolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Forgot Password",style: TextStyle(color: AppColors.textcolor,fontSize: 25),),
              SizedBox(height: 10,),
              Text("Enter the email address with your account and we'll send an email with confirmation to reset your password.",style: TextStyle(color: AppColors.textcolor),),
              SizedBox(height: 20,),
              TextFormField(
                controller: controller,
                style: TextStyle(color: AppColors.textcolor),
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: AppColors.textcolor),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height:170,),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: screenWidth*10,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                        onPressed: (){
                          if(controller.text==null){
                            Fluttertoast.showToast(msg: "Please Enter a valid email",
                            backgroundColor: Colors.red);
                          }
                          else{
                            FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).then((onValue){
                              Fluttertoast.showToast(msg: "Password send to Email",backgroundColor: Colors.greenAccent);
                            }).onError((error,StackTrace){
                              Fluttertoast.showToast(msg: "Please Enter a valid Email",backgroundColor: Colors.red);
                              Navigator.pop(context);
                            });
                          }
                        }, child: Text("Send Code",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}