extension DurationExtensions on Duration {
  String toYearsMonthsDaysString() {
    final years = this.inDays ~/ 365;
    // You will need a custom logic for the months part, since not every month has 30 days
    final months = (this.inDays ~% 365) ~/ 30
    final days = (this.inDays ~% 365) ~% 30

    return "$years years $months months $days days";
  }
}