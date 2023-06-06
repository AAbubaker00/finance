import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class SearchWelcome extends StatelessWidget {
  const SearchWelcome();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                child: Image.asset(
              'assets/icons/searchPage.png',
              width: 100,
              height: 100,
              color: chartTextColour,
            )),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Looking for investments?',
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
              'Browse our selection of investment',
              style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                    color: chartTextColour,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'opportunities',
              style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                    color: chartTextColour,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
