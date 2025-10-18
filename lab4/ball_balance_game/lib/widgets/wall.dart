import 'package:flutter/material.dart';

class Wall extends StatelessWidget {
  final double margin;
  final double thickness;

  const Wall({super.key, this.margin = 40, this.thickness = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: thickness),
      ),
    );
  }
}
