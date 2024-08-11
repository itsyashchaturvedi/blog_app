import 'package:flutter/material.dart';

class BlogItem extends StatelessWidget {
  final bool isFullWidth;
  final bool isFullShade;
  final bool isLastItem;

  BlogItem({
    required this.isFullWidth,
    this.isFullShade = false,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isFullWidth ? double.infinity : null,
        height: isLastItem ? 100 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
          image: isLastItem
              ? null
              : const DecorationImage(
            image: NetworkImage('https://via.placeholder.com/150'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLastItem
            ? Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(8),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Blog Title',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('Sep 15, 2021'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.comment, size: 16),
                        SizedBox(width: 4),
                        Text('3'),
                        SizedBox(width: 10),
                        Icon(Icons.thumb_up, size: 16),
                        SizedBox(width: 4),
                        Text('5'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0, // Ensures the width is the full width of the container
                child: Container(
                  width: 80,
                  height: isFullShade ? 200 : null,
                  color: Colors.black.withOpacity(isFullShade ? 0.6 : 0.6),
                  padding: const EdgeInsets.all(8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blog Title',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Sep 13, 2021',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(Icons.comment, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('3', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 10),
                          Icon(Icons.thumb_up, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('5', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            ),
     );
   }
}