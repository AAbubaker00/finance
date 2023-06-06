class TimestampCalculator {
  final List timestamp;
  final List values;

  TimestampCalculator({this.timestamp, this.values}) {
    _splitter();
  }

  _splitter() {
    List timestampSplit_a, timestampSplit_b = [];
    List valuesSplit_a, valuesSplit_b = [];

    var a = _sectionOne(timestampSplit_a: timestampSplit_a, valuesSplit_a: valuesSplit_a);
    var b = _sectionTwo(timestampSplit_b: timestampSplit_b, valuesSplit_b: valuesSplit_b);


    return {
      'a': await a;
    }



  }

  _sectionOne({List timestampSplit_a, List valuesSplit_a}) {}
  _sectionTwo({List timestampSplit_b, List valuesSplit_b}) {}
}
