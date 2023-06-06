import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  child: _allocations(),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  _allocations() {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[Text("£asdadasd"), Text("Total Gain")],
              ),
              Column(
                children: <Widget>[Text("£asdadasd"), Text("52 Week Gain")],
              ),
              Column(
                children: <Widget>[Text("£asdadasd"), Text("Monthly ")],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
              ),
              Column(
                children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
              ),
            ],
          )
        ],
      ),
    );
  }
}
