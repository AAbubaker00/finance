import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class Offline extends StatelessWidget {  const Offline();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/noConnection.png',
            width: 100,
            height: 100,
            color: chartTextColour,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Oooops!',
              style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: chartTextColour,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'No Internet Connection dound, Check your Connection ',
            style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                  color: chartTextColour,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
