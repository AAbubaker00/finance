class TimestampCalculator {
  final List timestamp;
  final List values;

  TimestampCalculator({this.timestamp, this.values}) {
    _splitter();
  }

  _splitter() {
    var a = _sectionOne(time);
    var b = _sectionTwo()(time);
    
  }

  _sectionOne(List time) {}

  _sectionTwo() {}
}
