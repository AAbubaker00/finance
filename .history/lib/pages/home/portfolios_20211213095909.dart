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

  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List portfolios = [];
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency = '', baseC = '';

  Map data = {};

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    data = ModalRoute.of(context).settings.arguments;
    portfolios = data['portfolios'];

    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: new Text("Step1"),
          leading: new IconButton(
            onPressed: () {},
            icon: new AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
          ),
        ),
        body: new Text("text"));
  }
}
