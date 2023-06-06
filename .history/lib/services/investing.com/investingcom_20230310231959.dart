import 'package:Valuid/shared/news/newsCard.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

final String _sFixedCryptoNewsEndPoint = 'https://www.investing.com/news/cryptocurrency-news';
final String _sFixedCommoditiesNewsEndPoint = 'https://www.investing.com/news/commodities-news';
// final String _sFixedMostPopularNewsEndPoint = 'https://www.investing.com/news/most-popular-news';

enum newsType { CRYPTO, COMMODITY }

class InvestingCom {
  List<dyanmic> cryptoNews = [];

  Future<List<dynamic>> getNews(newsType option) async {
    try {
      final response = await http.Client().get(
          Uri.parse(option == newsType.CRYPTO ? _sFixedCryptoNewsEndPoint : _sFixedCommoditiesNewsEndPoint));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var newsHeadlines = document.getElementsByClassName('js-article-item articleItem');

        newsHeadlines = newsHeadlines.length > 10 ? newsHeadlines.getRange(0, 10).toList() : newsHeadlines;

        for (var news in newsHeadlines) {
          var imgURL = news.children[0].children[0].attributes['data-src'];

          var title = news.children[1].children[0].text;

          // var date = news.getElementsByClassName('articleDetails');

          // print(date);

          var src = news.children[1].children[0].attributes['href'];

          if (src[0] == '/') {
            src = 'https://www.investing.com' + src;
          }

          var description = news.getElementsByClassName('textDiv').first.outerHtml;

          cryptoNews
              .add(NewsObject(src: src, description: description, date: '', title: title, imgURL: imgURL, provider: 'Investing.com'));
        }

        return cryptoNews;
      }

      return [];
    } catch (e) {
      PrintFunctions().printError(e.toString());

      return [];
    }
  }
}
