import 'package:flutter/material.dart';
import 'package:finance/shared/themes.dart';

class NewPortfolio extends StatefulWidget {
  @override
  _NewPortfolioState createState() => _NewPortfolioState();
}

class _NewPortfolioState extends State<NewPortfolio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DarkTheme().backgroundColour,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DarkTheme().backgroundColour,
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              data['data']['initalData']['portfolios'].forEach((portfolio) {
                // print(portfolio['name']);

                if (portfolio['name'] == data['portfolio']['portfolioName']) {
                  data['portfolio']['portfolioName'] =
                      name.isEmpty ? data['portfolio']['portfolioName'] : name;

                  data['portfolio']['baseCurrency'] =
                      baseCurrency.isEmpty ? data['portfolio']['baseCurrency'] : baseCurrency;

                  data['portfolio']['brooker'] =
                      description.isEmpty ? data['portfolio']['brooker'] : description;

                  data['data']['initalData']['portfolios']
                      [data['data']['initalData']['portfolios'].indexOf(portfolio)] = data['portfolio'];

                  print(data['data']['initalData']['portfolios']);
                }
              });

              // await DatabaseService(uid: user.uid).updateUserData(
              //     portfolios: data['initalData']['portfolios'],
              //     userDetails: data['userDetails']);

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false, arguments: data['data']);
            },
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 35,
            ),
            backgroundColor: DarkTheme().backgroundColour,
            elevation: 5,
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight*.7),
            child: AppBar(
              title: Text('New Portfolio', ),
              centerTitle: true,
            ),
          ),
          body: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
