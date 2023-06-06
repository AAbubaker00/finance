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
        preferredSize: Size.fromHeight(40),
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
      height: 500,
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          
        ],
      ),
    );
  }
}
