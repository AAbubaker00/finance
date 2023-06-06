import 'package:Valuid/pages/settings/settings.dart';
import 'package:Valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:Valuid/shared/Custome_Widgets/divider.dart/divider.dart';
import 'package:Valuid/shared/Custome_Widgets/portfolioCard/portfolioCard.dart';
import 'package:Valuid/shared/Custome_Widgets/scaffold/cw_scaffold.dart';
import 'package:Valuid/shared/TextStyle/customTextStyles.dart';
import 'package:Valuid/shared/ads/ad.dart';
import 'package:Valuid/shared/customPageRoute/customePageRoute.dart';
import 'package:Valuid/shared/dataObject/data_object.dart';
import 'package:Valuid/shared/themes/themes.dart';
import 'package:Valuid/shared/units/units.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'newPortfolio.dart';

class Dashboard extends StatefulWidget {
  final DataObject dataObject;

  Dashboard({Key key, this.dataObject}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ScrollController mainScrolController = ScrollController();

  BannerAd _bannerAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // _bannerAd = BannerAd(
    //     size: AdSize.banner,
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     listener: BannerAdListener(
    //         onAdLoaded: (_) => setState(() => isAdLoaded = true),
    //         onAdFailedToLoad: (_, error) => PrintFunctions().printStartEndLine(error)),
    //     request: AdRequest());

    // _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return CWScaffold(
      dataObject: widget.dataObject,
      scaffoldBgColour: scaffoldBgColourOptions.LIGHT,
      bottomAppBarBorderColour: true,
      appBarTitleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image.asset(
                  //   'assets/icons/testLogo.png',
                  //   width: 30,
                  //   height: 30,
                  //   // color: UserThemes(widget.dataObject.theme).iconColour,
                  // ),
                  Image.asset(
                    'assets/icons/name.png',
                    width: 80,
                    height: 80,
                    // color: UserThemes(widget.dataObject.theme).iconColour,
                  ),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(buttonRadius),
              highlightColor: Colors.transparent,
              onTap: () async => await Navigator.push(
                  context,
                  CustomPageRouteSlideTransition(
                      direction: AxisDirection.left, child: Settings(dataObject: widget.dataObject))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/icons/menu.png',
                  width: iconSize,
                  height: iconSize,
                  color: UserThemes(widget.dataObject.theme).iconColour,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        controller: mainScrolController,
        children: [
          CustomeAdWidget(bannerAd: _bannerAd, dataObject: widget.dataObject, isAdLoaded: isAdLoaded),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your portfolios',
                          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .portfolioNameStyle),
                              // .copyWith(
                              //     color:
                              //         UserThemes(widget.dataObject.theme).textColorVarient.withOpacity(.7))),
                      InkWell(
                        borderRadius: BorderRadius.circular(buttonRadius),
                        onTap: () => Navigator.push(
                            context,
                            CustomPageRouteSlideTransition(
                              direction: AxisDirection.left,
                              child: NewPortfolio(
                                dataObject: widget.dataObject,
                              ),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/icons/add_border.png',
                            width: iconSize,
                            height: iconSize,
                            color: UserThemes(widget.dataObject.theme).purpleVarient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: CustomDivider(dataObject: widget.dataObject),
                ),
                Column(
                  children: widget.dataObject.portfolios
                      .map<Widget>((portfolio) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(circularRadius),
                            onTap: () async {
                              widget.dataObject.onPortfolio = portfolio;

                              Navigator.push(
                                  context,
                                  CustomPageRouteSlideTransition(
                                      direction: AxisDirection.left,
                                      child: ViewPortfolio(dataObject: widget.dataObject)));
                            },
                            child: PortfolioCard(
                              dataObject: widget.dataObject,
                              portfolio: portfolio,
                            )),
                      ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
