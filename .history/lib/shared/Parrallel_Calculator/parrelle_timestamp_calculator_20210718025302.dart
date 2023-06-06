class TimestampCalculator {
  List timestamp = [], values = [];
  final Map asset;

  TimestampCalculator(this.asset) {
    timestamp = asset['marketData']['chartData']['max']['timestamp'];
    values = asset['marketData']['chartData']['max']['close'];
    asset['marketData']['chartData']['max']['months'] = [];

    _splitter();
  }

  _splitter() async {
    int splitLength = (timestamp.length / 2).round();

    List timestampSplitA = timestamp.getRange(0, splitLength - 1).toList(),
        timestampSplitB = timestamp.getRange(splitLength - 1, timestamp.length - 1).toList();
    List valuesSplitA = values.getRange(0, splitLength - 1).toList(),
        valuesSplitB = values.getRange(splitLength - 1, values.length - 1).toList();

    var a = _sectionOne(timestampSplitA: timestampSplitA, valuesSplitA: valuesSplitA);
    var b = _sectionTwo(timestampSplitB: timestampSplitB, valuesSplitB: valuesSplitB);
    
    
    await a;
    await b;

    
  }

  combine() {}

  _sectionOne({List timestampSplitA, List valuesSplitA}) {
    for (var date in timestampSplitA) {
      if (asset['marketData']['chartData']['max']['months'].isEmpty) {
        asset['marketData']['chartData']['max']['months'].add({
          'id': DateTime.parse(date).month,
          'dates': [
            {
              'date': date,
              'value': asset['marketData']['chartData']['max']['close']
                  [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
            }
          ]
        });
      } else {
        var isMonthExist = asset['marketData']['chartData']['max']['months']
            .firstWhere((month) => month['id'] == DateTime.parse(date).month, orElse: () => null);

        if (isMonthExist == null) {
          asset['marketData']['chartData']['max']['months'].add({
            'id': DateTime.parse(date).month,
            'dates': [
              {
                'date': date,
                'value': asset['marketData']['chartData']['max']['close']
                    [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
              }
            ]
          });
        } else {
          asset['marketData']['chartData']['max']['months']
                  [asset['marketData']['chartData']['max']['months'].indexOf(isMonthExist)]['dates']
              .add({
            'date': date,
            'value': asset['marketData']['chartData']['max']['close']
                [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
          });
        }
      }
    }
  }

  _sectionTwo({List timestampSplitB, List valuesSplitB}) {
    for (var date in timestampSplitB) {
      if (asset['marketData']['chartData']['max']['months'].isEmpty) {
        asset['marketData']['chartData']['max']['months'].add({
          'id': DateTime.parse(date).month,
          'dates': [
            {
              'date': date,
              'value': asset['marketData']['chartData']['max']['close']
                  [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
            }
          ]
        });
      } else {
        var isMonthExist = asset['marketData']['chartData']['max']['months']
            .firstWhere((month) => month['id'] == DateTime.parse(date).month, orElse: () => null);

        if (isMonthExist == null) {
          asset['marketData']['chartData']['max']['months'].add({
            'id': DateTime.parse(date).month,
            'dates': [
              {
                'date': date,
                'value': asset['marketData']['chartData']['max']['close']
                    [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
              }
            ]
          });
        } else {
          asset['marketData']['chartData']['max']['months']
                  [asset['marketData']['chartData']['max']['months'].indexOf(isMonthExist)]['dates']
              .add({
            'date': date,
            'value': asset['marketData']['chartData']['max']['close']
                [asset['marketData']['chartData']['max']['timestamp'].indexOf(date)]
          });
        }
      }
    }
  }
}
