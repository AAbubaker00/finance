import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: backgroundColour,
      highlightColor: backgroundColourVarient,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: iconColour.withOpacity(.005)),
                            borderRadius: BorderRadius.circular(circularRadius),
                            color: backgroundColour),
                        height: 110,
                        child: Row(children: []),
                      ),
                    ))),
      ),
    );
  }
}
