import 'package:blog_app/colorpack.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool _isObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgcolor,
        foregroundColor: AppColors.textcolor,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: AppColors.bgcolor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Password",
                style: TextStyle(color: AppColors.textcolor, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "This password should be different from the previous password",
                style: TextStyle(color: AppColors.textcolor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                obscureText: _isObscured,
                decoration: InputDecoration(
                    labelText: "New Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    labelStyle: TextStyle(color: AppColors.textcolor),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: AppColors.textcolor),
                obscureText: _isObscured,
                decoration: InputDecoration(

                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    labelStyle: TextStyle(color: AppColors.textcolor),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: 170,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: screenWidth * 10,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        onPressed: () {},
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}