import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/models/quote/quote.dart';
import 'package:valuid/services/database/database.dart';
import 'package:valuid/services/forex/forex_conversion.dart';
import 'package:valuid/services/marketbeat/marketbeat.dart';
import 'package:valuid/shared/dataObject/data_object.dart';

class PortfolioCalculations {
  PortfolioCalculations();

  portfolioCalculations({required PortfolioObject portfolio, required DataObject dataObject}) async {
    portfolio.value = 0;
    portfolio.invested = 0;
    portfolio.change = 0;
    portfolio.changePercent = 0;

    if (portfolio.holdings.isNotEmpty) {
      List<QuoteObject> b = await Marketbeat().getMarketbeatQuoteList(portfolio.holdings);

      portfolio.holdings = QuoteObject().combineToList(portfolio.holdings, b);

      for (var holding in portfolio.holdings) {
        double conversion = ForexConversion(baseCurrency: dataObject.account.currency)
            .getRate(await DatabaseService().getRates(), holding.currency);

        holding.regularMarketPrice *= conversion;
        holding.regularMarketChange *= conversion;

        holding.change =
            (holding.regularMarketPrice - (holding.purchasePrice * conversion)) * holding.quantity;
        holding.changePercent = (holding.change / holding.purchasePrice) * 100;
        holding.invested = holding.purchasePrice * holding.quantity * conversion;
        holding.value = holding.change + holding.invested;

        portfolio.value += holding.value;
        portfolio.invested += holding.invested;
        portfolio.change += holding.change;
        portfolio.changePercent = (portfolio.change / portfolio.invested) * 100;
      }
    }

    return portfolio;
  }
}
