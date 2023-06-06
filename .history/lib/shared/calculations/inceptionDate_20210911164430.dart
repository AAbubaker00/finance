class InceptionDate {
  getInceptionDae(List stocks) {
    var inceptionDate;
    if (stocks.length > 1) {
      stocks.sort((a, b) => DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate'])));
      inceptionDate = stocks[0]['buyDate'];
    } else {
      inceptionDate = stocks[0]['buyDate'];
    }

    return inceptionDate;
  }
}
