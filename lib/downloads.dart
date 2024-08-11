import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,color: Colors.white),
          onPressed: (){
          Navigator.pop(context);
        },
        ),
        title: const Text("Downloads",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              ListBody(
                children: [
                  Container()
                ],
              )
            ],
          ),

      ));
  }
}
