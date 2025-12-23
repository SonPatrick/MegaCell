import 'package:flutter/material.dart';

class CustomTitles extends StatefulWidget {
  final String title;
  final double value;
  const CustomTitles({super.key, required this.title, required this.value});

  @override
  State<CustomTitles> createState() => _CustomTitlesState();
}

class _CustomTitlesState extends State<CustomTitles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${widget.value}",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
