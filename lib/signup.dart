import 'package:blog_app/colorpack.dart';
import 'package:blog_app/controller/controller.dart';
import 'package:blog_app/login.dart';
import 'package:blog_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignuppageState();
}

class _SignuppageState extends State<SignupPage> {
  bool _isHovering = false;
  bool _isObsured = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 40, color: AppColors.textcolor),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Name", style: TextStyle(color: AppColors.textcolor)),
                  ),
                  TextFormField(
                    style: TextStyle(color: AppColors.textcolor),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Phone", style: TextStyle(color: AppColors.textcolor)),
                  ),
                  TextFormField(
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.textcolor),
                    decoration: InputDecoration(
                      hintText: "Your Number",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null, 
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Email", style: TextStyle(color: AppColors.textcolor)),
                  ),
                  TextFormField(
                    style: TextStyle(color: AppColors.textcolor),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Password", style: TextStyle(color: AppColors.textcolor)),
                  ),
                  TextFormField(
                    style: TextStyle(color: AppColors.textcolor),
                    obscureText: _isObsured,
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsured = !_isObsured;
                          });
                        },
                        icon: _isObsured
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined),
                      ),
                      hintText: "Your Password",
                      hintStyle: TextStyle(color: AppColors.hitcolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
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
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.textcolor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: screenWidth * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () async {
                          if(passwordController.text.length<8){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password must be of minimum 8 characters")));
                          }
                          else if(emailController.text.contains("@")==false){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid email having @ in it")));
                          }
                          else{
                          if (formKey.currentState!.validate()) {
                            try {
                              UserCredential credential =
                                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                              String id = credential.user!.uid;
                              UserModel user = UserModel(
                                name: nameController.text,
                                phoneNumber: int.parse(phoneController.text),
                                email: emailController.text,
                                password: passwordController.text,
                                id: id,
                              );

                              await Databasemethod().addUser(user.toJson(), id);

                              Fluttertoast.showToast(
                                msg: "Registered Successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.greenAccent.shade200,
                                textColor: Colors.white,
                                fontSize: 16,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Loginpage()),
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "Registration failed: $e",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16,
                              );
                              print("Error during registration: $e");
                            }
                          }
                          }
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: AppColors.hitcolor, thickness: 3),
                      ),
                      const SizedBox(width: 10),
                      Text("or continue with", style: TextStyle(color: AppColors.textcolor)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Divider(color: AppColors.hitcolor, thickness: 3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: boxWidth,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.textcolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.google, color: Colors.black, size: 40),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: boxWidth,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.textcolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.facebook, color: Colors.black, size: 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: TextStyle(color: AppColors.textcolor)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Loginpage()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Color.fromARGB(255, 80, 235, 14)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
