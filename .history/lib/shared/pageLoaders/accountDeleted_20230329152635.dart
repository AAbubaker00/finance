import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class AccountDeletedNotification extends StatelessWidget {
  const AccountDeletedNotification();

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
                Text(
                'Your account has been deleted',
                style: CustomTextStyles(context).overallCurrencyStyle.copyWith(
                      color: chartTextColour,
                    ),
                textAlign: TextAlign.center,
              ),
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
