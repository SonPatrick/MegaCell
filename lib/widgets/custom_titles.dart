import 'package:flutter/material.dart';

class CustomTitles extends StatefulWidget {
  final String title;
  final double value;
  final double valueSize;
  final double titleSize;
  const CustomTitles({
    super.key,
    required this.title,
    required this.value,
    this.valueSize = 23.0,
    this.titleSize = 16,
  });

  @override
  State<CustomTitles> createState() => _CustomTitlesState();
}

class _CustomTitlesState extends State<CustomTitles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "R\$ ${widget.value}",
          style: TextStyle(
            fontSize: widget.valueSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: widget.titleSize,
            fontWeight: FontWeight.normal,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}
