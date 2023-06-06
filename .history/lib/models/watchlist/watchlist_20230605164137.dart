import 'package:valuid/models/quote/quote.dart';

class WatchlistObject {
  late List<QuoteObject> watchlist;

  List<QuoteObject> docFromMap(List watchlist) =>
      List.generate(watchlist.length, (index) => QuoteObject.docWatchlistFromMap(watchlist[index]));
}
