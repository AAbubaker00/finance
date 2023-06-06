import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class DisclaimerWidget extends StatelessWidget {
  final String text;
  final DataObject dataObject;
  final bool showDisclaimerText;

  const DisclaimerWidget({Key? key, required this.text, this.dataObject, this.showDisclaimerText = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: <TextSpan>[
              showDisclaimerText? TextSpan(
                  text: 'Disclaimer: ',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)) : TextSpan(text: ''),
              TextSpan(
                text: text,
                style: TextStyle(
                  color: textColorVarient,
                  fontSize: 11,
                ),
              )
            ])));
  }
}
