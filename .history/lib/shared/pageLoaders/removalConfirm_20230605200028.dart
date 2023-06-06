import 'package:valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:valuid/shared/TextStyle/customTextStyles.dart';
import 'package:valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class RemovalCompletedNotification extends StatelessWidget {
  const RemovalCompletedNotification({required this.isStock, required this.name, this.secondaryName});

  final String name, secondaryName;
  final bool isStock;

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      scaffoldBgColour: BgTheme.LIGHT,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, size: 100, color: redVarient),
              SizedBox(
                height: 20,
              ),
              isStock
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: name,
                          style: CustomTextStyles(context)
                              .overallCurrencyStyle
                              .copyWith(color: redVarient, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: ' has been removed from your ',
                          style: CustomTextStyles(context).overallCurrencyStyle,
                        ),
                        TextSpan(
                          text: secondaryName,
                          style: CustomTextStyles(context)
                              .overallCurrencyStyle
                              .copyWith(color: redVarient, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: ' portfolio',
                          style: CustomTextStyles(context).overallCurrencyStyle,
                        ),
                      ]))
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'Portfolio ',
                          style: CustomTextStyles(context).overallCurrencyStyle,
                        ),
                        TextSpan(
                          text: name,
                          style: CustomTextStyles(context)
                              .overallCurrencyStyle
                              .copyWith(color: redVarient, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: ' has been removed',
                          style: CustomTextStyles(context).overallCurrencyStyle,
                        ),
                      ])),
              SizedBox(
                height: 30,
              ),
              CWApplyButton(
                function: () => Navigator.pop(context),
                verticalPadding: 20,
                customTextColour: Colors.white,
                btnText: 'CONTINUE',
              )
            ],
          ),
        ),
      ),
    );
  }
}
