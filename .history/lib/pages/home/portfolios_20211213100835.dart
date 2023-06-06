import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:intl/intl.dart';
import 'package:backdrop/backdrop.dart';

import 'package:Strice/shared/themes/themes.dart';
import 'package:Strice/shared/units/units.dart';
import 'package:flutter/material.dart';

class Portfolios extends StatefulWidget {
  Portfolios({Key key}) : super(key: key);

  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(duration: const Duration(milliseconds: 100), value: 1.0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  static const _PANEL_HEADER_HEIGHT = 500.0;

  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List portfolios = [];
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency = '', baseC = '';

  Map data = {};

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;

   Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData theme = Theme.of(context);
    return new Container(
      color: theme.primaryColor,
      child:     Ink(
                        padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
                        decoration: CustomDecoration(themeMode, true).baseContainerDecoration,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 15, top: 10, left: 5),
                                child: Text('Portfolios', style: CustomTextStyles(themeMode).sectionHeader)),
                            GridView.count(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              crossAxisCount: 1,
                              mainAxisSpacing: 5,
                              childAspectRatio:
                                  (ratio <= 1.6) || orientation.index == 1 ? 6.8 : ((width / height) / .115),
                              children: portfolios.map((p) {
                                return InkWell(
                                  onLongPress: () async {
                                    _showRemovePortfolioPanel(p);
                                  },
                                  onTap: () async {
                                    for (var asset in filterAssets) {
                                      if (asset['marketData']['chartData']['max'].isEmpty) {
                                        isChartError = true;
                                      }
                                    }

                                    if (isChartError == true) {
                                      await _quickUpdate();
                                    }

                                    timer.cancel();

                                    // print(p['cagr']);

                                    Navigator.pushNamed(context, '/portfolio',
                                            arguments: {'portfolio': p, 'data': data})
                                        .then((value) => setState(() {
                                              setTimer();
                                              updateChanges = true;
                                            }));
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Units().circularRadius),
                                  ),
                                  child: Ink(
                                    decoration: CustomDecoration(themeMode, false).baseContainerDecoration,
                                    padding: EdgeInsets.all(10), //(top: 15, left: 10, right: 10, bottom: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(p['name'].toString(),
                                                    style: CustomTextStyles(themeMode).portfolioNameStyle)),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                  p['portfolioValue'] > 1000000000
                                                      ? '$baseCurrency${NumberFormat.compact().format(p['portfolioValue'])}'
                                                      : '$baseCurrency${p['portfolioValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                  style: CustomTextStyles(themeMode).holdingValueStyle),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                    p['investedValue'] > 1000000000
                                                        ? '$baseCurrency${NumberFormat.compact().format(p['investedValue'])}'
                                                        : '$baseCurrency${p['investedValue'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}', //${p['baseCurrency']}
                                                    style: CustomTextStyles(themeMode).holdingSubValueStyle),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text(
                                                  p['change'] > 1000000000
                                                      ? '+$baseCurrency${NumberFormat.compact().format(p['change'])}'
                                                      : (double.parse(p['change'].toString())) >= 0
                                                          ? '+$baseCurrency${p['change'].toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse(p['change'].toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)'
                                                          : '-$baseCurrency${(p['change'] * -1).toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} (${(double.parse((p['change'] * -1).toString()) / double.parse(p['investedValue'].toString()) * 100).toStringAsFixed(2)}%)',
                                                  style: CustomTextStyles(themeMode)
                                                      .holdingSubValueStyle
                                                      .copyWith(
                                                          color: (double.parse(p['change'].toString()) >= 0
                                                              ? UserThemes(themeMode)
                                                                  .greenVarient //Colors.green
                                                              : UserThemes(themeMode).redVarient)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                  
    );
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - _PANEL_HEADER_HEIGHT;
    final double bottom = -_PANEL_HEADER_HEIGHT;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    data = ModalRoute.of(context).settings.arguments;
    portfolios = data['portfolios'];

    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text("Step1"),
        leading: new IconButton(
          onPressed: () {
            _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
          },
          icon: new AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
        ),
      ),
      body: new LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
