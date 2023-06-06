import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class Restricted extends StatelessWidget {
  final DataObject dataObject;

  const Restricted({Key key, @required this.dataObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      // decoration:
      //     CustomDecoration( false).baseContainerDecoration.copyWith(),
      //     padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              child: Image.asset(
            'assets/icons/invis.png',
            width: 40,
            height: 40,
            color: iconColour,
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sign up with email to access \n this section.',
            style: CustomTextStyles( dataObject.context).portfolioSubValuetyle.copyWith(fontSize: 19),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}
