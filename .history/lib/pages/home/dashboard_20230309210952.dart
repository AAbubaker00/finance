import 'package:Valuid/pages/settings/settings.dart';
import 'package:Valuid/pages/viewPortfolio/viewPortfolio.dart';
import 'package:Valuid/shared/Custome_Widgets/button/cw_button.dart';
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
    print('object');
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
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(
                'assets/icons/profile.png',
                width: iconSize,
                height: iconSize,
                // color: UserThemes(widget.dataObject.theme).iconColour,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.dataObject.user.email,
                  style:
                      CustomTextStyles(widget.dataObject.theme, widget.dataObject.context).portfolioNameStyle.copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
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
            padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your portfolios',
                          style: CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                              .portfolioNameStyle),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(
                          widget.dataObject.portfolios.length + 1,
                          (index) => index == widget.dataObject.portfolios.length
                              ? Container()
                              : widget.dataObject.portfolios[index])
                      .map<Widget>((portfolio) => portfolio.runtimeType == Container
                          ? CWApplyButton(
                              // addBlur: true,
                              isLinearGradient: true,
                              dataObject: widget.dataObject,
                              isBgColurOn: false,
                              customColour: UserThemes(widget.dataObject.theme).blueVarient,
                              customTextColour: UserThemes(widget.dataObject.theme).summaryColour,
                              customTextStyle:
                                  CustomTextStyles(widget.dataObject.theme, widget.dataObject.context)
                                      .appBarTitleStyle
                                      .copyWith(
                                          letterSpacing: 1,
                                          color: UserThemes(widget.dataObject.theme).summaryColour,
                                          fontWeight: FontWeight.w600),
                              function: () => Navigator.push(
                                  context,
                                  CustomPageRouteSlideTransition(
                                    direction: AxisDirection.left,
                                    child: NewPortfolio(
                                      dataObject: widget.dataObject,
                                    ),
                                  )),
                              btnText: 'ADD PORTFOLIO',
                              verticalPadding: 20,
                              addBorder: false,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
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
                                    index: widget.dataObject.portfolios.indexOf(portfolio),
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
