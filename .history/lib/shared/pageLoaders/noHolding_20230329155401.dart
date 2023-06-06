import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoHoldings extends StatelessWidget {
  const NoHoldings();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: summaryColour,
        padding: EdgeInsets.symmetric(value),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
                child: Image.asset(
              'assets/icons/noHolding.png',
              width: 100,
              height: 100,
              color: chartTextColour,
            )),
            SizedBox(
              height: 15,
            ),
            Text(
              "Looks like you haven't added any investments yet",
              style: CustomTextStyles(context).holdingValueStyle.copyWith(color: chartTextColour),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Why not take the first step towards securing your financial future by exploring our tracking tools?',
              style: CustomTextStyles(context).portfolioNameStyle.copyWith(color: chartTextColour),
              textAlign: TextAlign.center,

            )
          ],
        ));
  }
}
