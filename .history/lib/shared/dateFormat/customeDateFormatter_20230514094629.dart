class CustomDateFormatter {
  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final weekdaysFull = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  final monthsShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  getDateTerm(int lastChar) {
    if (lastChar > 10 && lastChar != 11 && lastChar != 13 && lastChar != 12) {
      lastChar = int.parse((lastChar.toString()[1]));
    } else if (lastChar == 13) {
      return 'rd';
    } else if (lastChar == 11 || lastChar == 12) {
      return 'th';
    }

    switch (lastChar) {
      case 1:
        return 'st';
        break;
      case 2:
        return 'nd';
        break;
      case 3:
        return 'rd';
        break;
      default:
        return 'th';
        break;
    }
  }

  formatDateStyle(var date) {
    return '${DateTime.parse(date).day.toString()}${getDateTerm(DateTime.parse(date).day)} ${monthsShort[DateTime.parse(date).month - 1]} ${DateTime.parse(date).year.toString()}';
  }

  calenderHeaderStyle(var date, {var date2}) {
    if (date2 != null) {
      return '${DateTime.parse(date).day.toString()}${getDateTerm(DateTime.parse(date).day)} ${months[DateTime.parse(date).month - 1]} - ${DateTime.parse(date2).day.toString()}${getDateTerm(DateTime.parse(date2).day)} ${months[DateTime.parse(date2).month - 1]}';
    } else {
      return '${DateTime.parse(date).day.toString()}${getDateTerm(DateTime.parse(date).day)}, ${months[DateTime.parse(date).month - 1]} ${DateTime.parse(date).year.toString()}';
    }
  }

  dateDifference(var date) {
    return DateTime.parse(date).difference(DateTime.now()).inDays.toString();
  }

  getInceptionDae(List stocks) {
    var inceptionDate;
    if (stocks.length > 1) {
      stocks.sort((a, b) => DateTime.parse(a['buyDate']).compareTo(DateTime.parse(b['buyDate'])));
      inceptionDate = stocks[0]['buyDate'];
    } else {
      // print(stocks[0]);
      inceptionDate = stocks[0]['buyDate'];
    }

    return DateTime.parse(inceptionDate.toString());
  }

  getTimeDifferenceToString(var date) {
    Duration difference = DateTime.now().difference(DateTime.parse(date));

    if (difference.inDays >= 1) {
      return difference.inDays.toInt().toString() + ' days ago';
    } else if (difference.inHours <= 24 && difference.inHours >= 1) {
      return difference.inHours.toInt().toString() + ' hours ago';
    } else if (difference.inMinutes <= 60 && difference.inMinutes >= 1) {
      return difference.inMinutes.toInt().toString() + ' minutes ago';
    } else {
      return difference.inSeconds.toString() + ' seconds';
    }
  }

  List<Map> eventMonths = [
    {
      'id': "January",
      'isSelected': false,
      'status': false,
      'index': 1,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "February",
      'isSelected': false,
      'status': false,
      'index': 2,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "March",
      'isSelected': false,
      'status': false,
      'index': 3,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "April",
      'isSelected': false,
      'status': false,
      'index': 4,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "May",
      'isSelected': false,
      'status': false,
      'index': 5,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "June",
      'isSelected': false,
      'status': false,
      'index': 6,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "July",
      'isSelected': false,
      'status': false,
      'index': 7,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "August",
      'isSelected': false,
      'status': false,
      'index': 8,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "September",
      'isSelected': false,
      'status': false,
      'index': 9,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "October",
      'isSelected': false,
      'status': false,
      'index': 10,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "November",
      'isSelected': false,
      'status': false,
      'index': 11,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    },
    {
      'id': "December",
      'isSelected': false,
      'status': false,
      'index': 12,
      'totalPayment': 0,
      'events': [],
      'divTotal': 0,
      'exTotal': 0,
      'earnTotal': 0,
      'holidayTotal': 0
    }
  ];
}
