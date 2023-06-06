import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:valuid/shared/units/units.dart';
import 'package:flutter/material.dart';

class CWConfirmBottomSheetButton extends StatelessWidget {
  final String? btnText;

  final Function? function;
  final Function? cancelBtnFunction;

  final DataObject? dataObject;

  final BuildContext? context;

  final bool isRed;

  CWConfirmBottomSheetButton(
      {Key? key,
      this.btnText,
      this.function,
      this.dataObject,
      this.context,
      this.cancelBtnFunction,
      this.isRed = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: EdgeInsets.only(bottom: 8.0, right: 10, left: 10),
        child: Container(
            width: 70,
            padding: EdgeInsets.all(3.5),
            decoration: CustomDecoration().curvedContainerDecoration.copyWith(color: backgroundColourVarient),
            child: Row(children: [])),
      ),
      Ink(
          decoration: BoxDecoration(
              color: summaryColour,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circularRadius), topRight: Radius.circular(circularRadius))),
          padding: const EdgeInsets.only(top: 20.0, bottom: 15, left: 15, right: 15),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
            Text(
              btnText!,
              style: CustomTextStyles(context).holdingValueStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Divider(thickness: .8, color: seperator.withOpacity(.5)),
            ),
            InkWell(
                borderRadius: BorderRadius.circular(circularRadius),
                onTap: function!(),
                child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(circularRadius),
                        color: isRed ? redVarient_2.withOpacity(.05) : summaryColour),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.0),
                          child: Text('CONFIRM',
                              style: CustomTextStyles(context)
                                  .holdingValueStyle
                                  .copyWith(color: isRed ? redVarient_2 : textColor)))
                    ])))
          ]))
    ]);
  }
}

// ignore: must_be_immutable
class CWApplyButton extends StatelessWidget {
  final Function? function;

  final bool isChange;
  final bool addBorder;
  final bool isBgColurOn;
  final bool isLinearGradient;

  final Border? customBorder;

  BorderRadius? borderRadius;

  final Color? customColour;
  final Color? customTextColour;

  final double verticalPadding;

  TextStyle? customTextStyle;
  final bool addBlur;
  final Widget? icon;
  final bool iconOnly;

  final String btnText;

  CWApplyButton(
      {Key? key,
      this.customBorder,
      this.function,
      this.btnText = 'CONFIRM',
      this.isChange = true,
      this.customColour,
      this.customTextColour,
      this.icon,
      this.addBorder = false,
      this.verticalPadding = 16,
      this.isBgColurOn = true,
      this.customTextStyle,
      this.addBlur = false,
      this.isLinearGradient = false,
      this.borderRadius,
      this.iconOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (customTextStyle == null) {
      customTextStyle = CustomTextStyles(context).holdingValueStyle.copyWith(
          color: customTextColour != null
              ? customTextColour
              : isChange
                  ? textColor
                  : textColorVarient);
    }

    if (borderRadius == null) {
      borderRadius = BorderRadius.circular(circularRadius);
    }
    return InkWell(
      onTap: function !=  null? function!(),
      borderRadius: borderRadius,
      child: Container(
        decoration: CustomDecoration().bottomsheetDecoration.copyWith(
            borderRadius: borderRadius,
            boxShadow: addBlur
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
                : [],
            color: isBgColurOn ? backgroundColour : Colors.transparent,
            border: Border.all(color: Colors.transparent)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20),
          decoration: CustomDecoration().bottomsheetDecoration.copyWith(
              borderRadius: borderRadius,
              color: customColour != null ? customColour : blueVarient.withOpacity(isChange ? .8 : .3),
              border: customBorder == null
                  ? Border.all(
                      width: .7,
                      color: seperator.withOpacity(
                        addBorder ? .8 : .0,
                      ))
                  : customBorder),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? icon! : Container(),
              iconOnly
                  ? Container()
                  : Flexible(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        btnText,
                        style: customTextStyle,
                      )
                    ]))
            ],
          ),
        ),
      ),
    );
  }
}
