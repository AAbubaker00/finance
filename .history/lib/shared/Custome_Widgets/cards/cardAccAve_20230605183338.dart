import 'package:flutter/material.dart';

class CardAccAve extends StatelessWidget {
  CardAccAve({
    required this.leftBorder,
    @required this.rightBorder,
    @required this.percentage,
    @required this.color,
  });


  final double leftBorder;
  final double rightBorder;
  final int percentage;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: percentage,
      child: SizedBox(
        height: 20,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
          color: color,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(leftBorder),
              topLeft: Radius.circular(leftBorder),
              bottomRight: Radius.circular(rightBorder),
              topRight: Radius.circular(rightBorder),
            ),
          ),
        ),
      ),
    );
  }
}