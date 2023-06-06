class NewsObject {
  String date;
  String title;
  String src;
  String description;
  String imgURL;
  String provider;

  NewsObject({required this.date,required  this.title, required this.description,required  this.imgURL,required  this.provider,required  this.src});

  newsObjectToMap(NewsObject newsObject) => {
        'date': newsObject.date,
        'title': newsObject.title,
        'src': newsObject.src,
        'description': newsObject.description,
        'imgURL': newsObject.imgURL,
        'provider': newsObject.provider
      };

  NewsObject.fromMap(Map newsObjectMap)
      : date = newsObjectMap['pubDate'],
        title = newsObjectMap['title'],
        description = newsObjectMap['description'],
        imgURL = newsObjectMap['thumbnail'],
        src = newsObjectMap['link'];
}
