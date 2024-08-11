import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor:Color.fromARGB(115, 91, 84, 84),
          child: IconButton(
            color: Colors.greenAccent,
            icon: Icon(icon),
            onPressed: () {},
          ),
        ),
        Text(label,style: TextStyle(color: Colors.white),),
      ],
    );
  }
}