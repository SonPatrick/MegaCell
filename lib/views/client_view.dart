import 'package:flutter/material.dart';
import 'package:megacell/widgets/custom_titles.dart';

class ClientView extends StatefulWidget {
  final double precoFinal;
  final double parcX6;
  final double parcX12;

  const ClientView({
    super.key,
    required this.precoFinal,
    required this.parcX6,
    required this.parcX12,
  });

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "MegaCell",
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.2,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,

            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,

              children: [
                CustomTitles(title: "Valor total", value: widget.precoFinal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
