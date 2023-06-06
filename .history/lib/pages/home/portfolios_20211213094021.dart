import 'package:Strice/shared/TextStyle/customTextStyles.dart';
import 'package:Strice/shared/decoration/customDecoration.dart';
import 'package:intl/intl.dart';

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

  List<String> sortOptions = ['Investment', 'Return', 'Buy Date', 'Shares', 'A-Z'];
  List portfolios = [];
  String selectedSortOption = 'Return', inceptionDate = '';
  String baseCurrency = '', baseC = '';

  Map data = {};

  double circularRadius = 15, ratio, width, height;

  var themeMode = true;

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height -300;
    final double bottom = -100;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

   Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData theme = Theme.of(context);
    return new Container(
      color: theme.primaryColor,
      child: new Stack(
        children: <Widget>[
          new Center(
            child: new Text("base"),
          ),
          new PositionedTransition(
            rect: animation,
            child: new Material(
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0)),
              elevation: 12.0,
              child: new Column(children: <Widget>[
                new Container(
                  height: 300,
                  child: new Center(child: new Text("panel")),
                ),
                new Expanded(child: new Center(child: new Text("content")))
              ]),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    data = ModalRoute.of(context).settings.arguments;
    portfolios = data['portfolios'];

  

    return Container(
      color: UserThemes(themeMode).backgroundColour,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () => _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [Text(selectedSortOption), Icon(Icons.keyboard_arrow_down_rounded)],
            ),
          ),
        ),
      )),
    );
  }
}
