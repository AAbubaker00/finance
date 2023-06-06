import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/decoration/customDecoration.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomeAdWidget extends StatelessWidget {
  final bool isAdLoaded;
  final BannerAd bannerAd;
  final DataObject dataObject;

  CustomeAdWidget({required this.isAdLoaded, required this.bannerAd, required this.dataObject});

  @override
  Widget build(BuildContext context) {
    if (isAdLoaded) {
      return Container(
        decoration: CustomDecoration().topWidgetDecoration,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              alignment: Alignment.center,
              child: AdWidget(
                ad: bannerAd,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }
}
