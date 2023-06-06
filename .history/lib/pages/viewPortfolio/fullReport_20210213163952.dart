import 'package:flutter/material.dart';
import 'package:finance/shared/themes.dart';

class FullReport extends StatefulWidget {
  @override
  _FullReportState createState() => _FullReportState();
}

class _FullReportState extends State<FullReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight*0.8),
            child: AppBar(
                centerTitle: true,
                elevation: 25,
                backgroundColor: DarkTheme().backgroundColour,
                actions: [
                  
                title: Text('Full Report',
                    style: TextStyle(color: DarkTheme().textColorVarient, fontSize: 17)),
              ),
          ),
        ),
      ),
    );
  }
}