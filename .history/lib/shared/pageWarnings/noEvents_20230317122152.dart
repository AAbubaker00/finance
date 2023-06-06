import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoEvents extends StatelessWidget {
  final Map 
  const NoEvents();

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
              'assets/icons/cal.png',
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
                'Currently no events on ${selectedMonth['id']}',
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
              'Try refreshing or check back later.',
              style: CustomTextStyles(context).portfolioNameStyle.copyWith(
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
