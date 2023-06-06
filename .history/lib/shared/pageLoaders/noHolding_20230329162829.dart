import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoHoldings extends StatelessWidget {
  const NoHoldings();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: summaryColour,
        padding: EdgeInsets.symmetric(horizontal: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(8.0),
              child: Text(
                "Looks like you haven't added any investments yet.",
                style: CustomTextStyles(context).portfolioNameStyle.copyWith(color: chartTextColour),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
