import 'package:blog_app/newpassword.dart';
import 'package:blog_app/colorpack.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgcolor,
        foregroundColor: AppColors.textcolor,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
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
                "Please Check Your Email",
                style: TextStyle(color: AppColors.textcolor, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We have sent the code to ----------email",
                style: TextStyle(color: AppColors.textcolor),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 50,
                    height: 120,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textcolor,
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordPage()));
                        },
                        child: Text(
                          "Verify",
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