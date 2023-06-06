import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoPosts extends StatelessWidget {
  const NoPosts();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: summaryColour,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  child: Image.asset(
                'assets/icons/feed.png',
                width: 100,
                height: 100,
                color: chartTextColour,
              )),
              SizedBox(
                height: 15,
              ),
              Text(
                'No posts yet.',
                style: CustomTextStyles(context).holdingValueStyle.copyWith(
                      color: chartTextColour,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Be the first to post on the social.',
                style: CustomTextStyles(context).portfolioNameStyle.copyWith(
                      color: chartTextColour,
                    ),
              )
            ],
          )),
    );
  }
}
