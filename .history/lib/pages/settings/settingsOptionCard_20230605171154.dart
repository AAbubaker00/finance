import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final DataObject dataObject;
  final Map option;

  const OptionCard({Key? key,reequired this.dataObject, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularRadius)),
      onTap: option['function'],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  option['img'],
                  width: iconSize,
                  height: iconSize,
                  color: iconColour,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    option['id'],
                    style: CustomTextStyles( dataObject.context).portfolioNameStyle,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: iconColour,
            )
          ],
        ),
      ),
    );
  }
}