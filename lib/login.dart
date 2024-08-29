import 'package:blog_app/forgotpass.dart';
import 'package:blog_app/homepage.dart';
import 'package:blog_app/navigation.dart';
import 'package:blog_app/signup.dart';
import 'package:blog_app/colorpack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _isHovering = false;
  bool _isObsured = true;
  void facebookSignin() async{
    try{
      await FacebookAuth.i.login(permissions: ['email','public_profile']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navigation(uid: "",isSignin: true,isfb: true,)));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text("Welcome to Syllex Blog"))));
    }
    catch(error)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
    }

  }
  void googleSignin() async{
    GoogleSignIn googleSignIn=GoogleSignIn();
    try{
      var result= await googleSignIn.signIn();
      if(result==null){
        return;
      }
      final userData= await result.authentication;
      final credential=GoogleAuthProvider.credential(idToken: userData.idToken,
      accessToken: userData.accessToken);
      var finalResult=FirebaseAuth.instance.signInWithCredential(credential);

    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Navigation(isSignin:true,uid: "",)));
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxwidth = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Log In",
                      style:
                          TextStyle(fontSize: 40, color: AppColors.textcolor),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Email",
                      style: TextStyle(color: AppColors.textcolor),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: AppColors.textcolor),
                    controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required Fields";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Password",
                        style: TextStyle(color: AppColors.textcolor)),
                  ),
                  TextFormField(
                    style: TextStyle(color: AppColors.textcolor),
                    controller: passwordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required Fields";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isObsured,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObsured = !_isObsured;
                            });
                          },
                          icon: _isObsured
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.remove_red_eye_outlined)),
                      hintText: "Your Password",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color:
                                _isHovering ? Colors.blue : AppColors.textcolor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textcolor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: screenWidth * 10,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35))),
                            onPressed: ()async {
                              if (_formKey.currentState!.validate()) {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text)
                                    .then((value) {
                                  Fluttertoast.showToast(
                                    msg: "Welcome to Syllex",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.greenAccent,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                  );
                                  // Navigate to the home page
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navigation(uid: FirebaseAuth.instance.currentUser!.uid.toString(),)),
                                  );
                                }).onError((error, stackTrace){
                                          Fluttertoast.showToast(msg: "Wrong Credentials! Please Check you Email or Password.",
                                          backgroundColor: Colors.red,
                                          gravity: ToastGravity.BOTTOM);
                                        });
                              }
                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ))),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.hitcolor,
                          thickness: 3,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "or continue with",
                        style: TextStyle(color: AppColors.textcolor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.hitcolor,
                          thickness: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: boxwidth,
                        height: 100,
                        decoration: BoxDecoration(
                            color: AppColors.textcolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                            onPressed: () {
                              googleSignin();
                            },
                            icon: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.black,
                              size: 40,
                            )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: boxwidth,
                        height: 100,
                        decoration: BoxDecoration(
                            color: AppColors.textcolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                            onPressed: () {
                              facebookSignin();
                            },
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.black,
                              size: 40,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(color: AppColors.textcolor),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 80, 235, 14)),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
