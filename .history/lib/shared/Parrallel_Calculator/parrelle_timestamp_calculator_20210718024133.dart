class TimestampCalculator {
  final List timestamp;
  final List values;

  TimestampCalculator({this.timestamp, this.values}) {
    _splitter();
  }

  _splitter() async {
    int splitLength = (timestamp.length / 2).round();

    List timestampSplit_a = timestamp.getRange(0, splitLength - 1),
        timestampSplit_b = timestamp.getRange(splitLength - 1, timestamp.length - 1);
    List valuesSplit_a =  values.getRange(0, splitLength - 1), valuesSplitB = values.getRange(splitLength -1, values.length -1);

    var a = _sectionOne(timestampSplit_a: timestampSplit_a, valuesSplit_a: valuesSplit_a);
    var b = _sectionTwo(timestampSplit_b: timestampSplit_b, valuesSplitB: valuesSplitB);

    return {'a': await a, 'b': await b};
  }

  _sectionOne({List timestampSplit_a, List valuesSplit_a}) {}
  _sectionTwo({List timestampSplit_b, List valuesSplitB}) {}
}
