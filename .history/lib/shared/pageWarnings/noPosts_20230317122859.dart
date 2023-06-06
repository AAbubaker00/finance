import 'package:Valuid/shared/themes/themes.dart';
import 'package:flutter/material.dart';

import '../TextStyle/customTextStyles.dart';

class NoPosts extends StatelessWidget {
  const NoPosts(this.selectedMonth);

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
                style: CustomTextStyles(widget.dataObject.context).holdingValueStyle.copyWith(
                      color: chartTextColour,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Be the first to post on the community.',
                style: CustomTextStyles(widget.dataObject.context).portfolioNameStyle.copyWith(
                      color: chartTextColour,
                    ),
              )
            ],
          )),
    );
  }
}
