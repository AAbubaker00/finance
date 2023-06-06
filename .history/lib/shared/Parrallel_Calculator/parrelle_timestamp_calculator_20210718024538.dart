class TimestampCalculator {
  final List timestamp;
  List values;

  TimestampCalculator(Map Asset) {
    this.timestamp = []; 

    _splitter();
  }

  _splitter() async {
    int splitLength = (timestamp.length / 2).round();

    List timestampSplitA = timestamp.getRange(0, splitLength - 1),
        timestampSplitB = timestamp.getRange(splitLength - 1, timestamp.length - 1);
    List valuesSplitA =  values.getRange(0, splitLength - 1), valuesSplitB = values.getRange(splitLength -1, values.length -1);

    var a = _sectionOne(timestampSplitA: timestampSplitA, valuesSplitA: valuesSplitA);
    var b = _sectionTwo(timestampSplitB: timestampSplitB, valuesSplitB: valuesSplitB);

    return {'a': await a, 'b': await b};
  }




  _sectionOne({List timestampSplitA, List valuesSplitA}) {


  }
  _sectionTwo({List timestampSplitB, List valuesSplitB}) {}
}
