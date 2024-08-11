import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Changes extends StatefulWidget {
  String type;
  String changes;
  bool numKeyboard;
  bool dateInfo;
  String dob;
  Changes({this.dob="2001-01-15",this.dateInfo=false,super.key,required this.changes,required this.type,this.numKeyboard=false});

  @override
  State<Changes> createState() => _ChangesState();
}

class _ChangesState extends State<Changes> {
  @override
  Widget build(BuildContext context) {
    DateTime? date;
    DateTime userDOb=DateTime.parse(widget.dob);
    String finalDate= "${userDOb.day}-${userDOb.month}-${userDOb.year}";
    Future<void> getDate() async{
      date = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-15),
        firstDate: DateTime(1950),
        lastDate: DateTime(DateTime.now().year-15)
      );
    }
    TextEditingController controller=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width-15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                  colors: <Color>[
                    Colors.purpleAccent,
                    Colors.deepPurpleAccent,
                  ]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:Text(widget.type,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),)
              ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
                  child: Center(child: Text("Manage your ${widget.type.toLowerCase()} to make sure your ${widget.type.toLowerCase()} is up to date. You have added this ${widget.type.toLowerCase()} for this account."
                  ,style: const TextStyle(fontSize: 16.5),)),
                ),
                widget.dateInfo?
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(

                            width: MediaQuery.of(context).size.width-25,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black
                              )
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Current Date of Birth: ${finalDate}",style: const TextStyle(color: Colors.black,fontSize: 17,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500),),
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(onPressed: ()
                                {
                                  getDate();
                                },
                                    icon: const Icon(Icons.date_range_rounded))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      TextFormField(
                    keyboardType: widget.numKeyboard?TextInputType.phone:TextInputType.text,
                    controller: controller,
                    onFieldSubmitted: (value){},
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.change_circle_sharp,color: Colors.black,),
                      fillColor: Colors.black,
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      //enabled: ,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintStyle: const TextStyle(color: Colors.black,fontSize: 18.5),
                      hintText: widget.changes,
                    ),
                  ),
                ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                    child: OutlinedButton(
                    onPressed: (){
                      if(widget.dateInfo)
                      {
                        if(date?.year.toString()==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Your Date of Birth",style: TextStyle(color: Colors.red),)));
                        }
                        else {
                          Fluttertoast.showToast(msg: "Date of Birth Updated!");
                          Navigator.pop(context);
                        }
                      }
                      else {
                        if (widget.numKeyboard) {
                          if (controller.text
                              .toString()
                              .length != 10 || controller.text
                              .toString()
                              .length > 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                  "Please enter a valid 10-digit mobile number",
                                  style: TextStyle(color: Colors.red),)));
                          }
                          else {
                            Fluttertoast.showToast(msg: "Contact Info Updated!");
                            Navigator.pop(context);
                          }
                        }
                        else if (widget.type == "Email") {
                          if (controller.text.toString().contains('@') ||
                              controller.text
                                  .toString()
                                  .length > 10) {
                            Fluttertoast.showToast(msg: "Email Updated!");
                            Navigator.pop(context);
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                  "Please enter a valid email having '@' in it",
                                  style: TextStyle(color: Colors.red),)));
                          }
                        }
                        else if (controller.text == null || controller.text ==
                            "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                "Please add some text to update",
                                style: TextStyle(color: Colors.red),)));
                        }
                        else {
                          Fluttertoast.showToast(msg: "${widget.type} Updated!");
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("Submit",style: TextStyle(color: Colors.indigo,fontSize: 22,fontWeight: FontWeight.bold),))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
