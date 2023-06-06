import 'package:valuid/models/quote/quote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PortfolioObject {
  late String name;
  dynamic goal;

  double invested = 0;
  double value = 0;
  double change = 0;
  double changePercent = 0;

  List<QuoteObject> holdings = [];
  

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
