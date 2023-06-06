import 'package:valuid/models/quote/quote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PortfolioObject {
  late String name;
  late dynamic goal;

  late double invested = 0;
  late double value = 0;
  late double change = 0;
  late double changePercent = 0;

  late List<QuoteObject> holdings = [];
  

  PortfolioObject();

  PortfolioObject.fromMap(Map data)
      : name = data['name'],
        goal = data['goal'],
        holdings = QuoteObject().listMapToQuote(data['holdings']);

  List<PortfolioObject> listPortfolioObjectFromMap(DocumentSnapshot data) =>
      List.generate(data['portfolios'].length, (index) => PortfolioObject.fromMap(data['portfolios'][index]));

  Map portfolioToMap(PortfolioObject portfolio) => {
        'name': portfolio.name,
        'goal': double.parse(portfolio.goal.toString()),
        'holdings': QuoteObject().listQuoteToMap(portfolio.holdings)
      };

  List<Map> listPortfolioToMap(List<PortfolioObject> portfolios) =>
      List.generate(portfolios.length, (index) => portfolioToMap(portfolios[index]));
}
