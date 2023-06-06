class NewsObject {
  final String date;
  final String title;
  final String src;
  final String description;
  final String imgURL;

  NewsObject({this.date, this.title, this.src, this.description, this.imgURL});
}


class NewsCard extends StatelessWidget {
  NewsObject feed;
  
  const NewsCard({Key? key}) : super(key: key);
  NewsObject feed;
  

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
