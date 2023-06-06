import 'package:valuid/pages/news/newsObject.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

final String _sFixedCryptoNewsEndPoint = 'https://www.investing.com/news/cryptocurrency-news';
final String _sFixedCommoditiesNewsEndPoint = 'https://www.investing.com/news/commodities-news';
final String _sFixedPoliticsNewsEndPoint = 'https://www.investing.com/news/politics';
final String _sFixedCurrencyNewsEndPoint = 'https://www.investing.com/news/forex-news';
final String _sFixedWorldNewsEndPoint = 'https://www.investing.com/news/world-news';
final String _sFixedEconomyNewsEndPoint = 'https://www.investing.com/news/economy';

final selectedUrl = '';

enum NewsType { CRYPTO, COMMODITY, POLITITCS, ECONOMY, WORLD, CURRENCY }

class InvestingCom {
  List<NewsObject> news = [];
  final NewsType newsType;

  InvestingCom({required this.newsType});

  Future<List<dynamic>> getNews() async {
    final response = await http.Client().get(Uri.parse(getNewsTypeUrl()));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);

      var newsHeadlines = document.getElementsByClassName('js-article-item articleItem');

      newsHeadlines = newsHeadlines.length > 10 ? newsHeadlines.getRange(0, 10).toList() : newsHeadlines;

      for (var feed in newsHeadlines) {
        try {
          var imgURL = feed.children[0].children[0].attributes['data-src'];

          var title = feed.children[1].children[0].text;

          var src = feed.children[1].children[0].attributes['href'];

          if (src[0] == '/') {
            src = 'https://www.investing.com' + src;
          }

          var description = feed.children[1].children.length == 3 ? feed.children[1].children[2].text : '';

          news.add(NewsObject(
              date: '',
              description: description,
              imgURL: imgURL.toString(),
              provider: 'Investing.com',
              src: src,
              title: title));
        } catch (e) {
          print('DIfferent format investing.com');
        }
      }

      return news;
    }

    return [];
  }

  getNewsTypeUrl() {
    switch (newsType.name) {
      case 'COMMODITY':
        return _sFixedCommoditiesNewsEndPoint;
        break;
      case 'CRYPTO':
        return _sFixedCryptoNewsEndPoint;
        break;
      case 'POLITICS':
        return _sFixedPoliticsNewsEndPoint;
        break;
      case 'CURRENCY':
        return _sFixedCurrencyNewsEndPoint;
        break;
      case 'WORLD':
        return _sFixedWorldNewsEndPoint;
        break;
      case 'ECONOMY':
        return _sFixedEconomyNewsEndPoint;
        break;
    }
  }
}
