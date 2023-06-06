import 'package:json_annotation/json_annotation.dart';

part 'yahoo_calenderEvents.g.dart';

@JsonSerializable()
class Yahoo_calenderEvents {
    num maxAge;
    Map<String,dynamic> earnings;
    Map<String,dynamic> exDividendDate;
    Map<String,dynamic> dividendDate;
    
    factory Yahoo_calenderEvents.fromJson(Map<String,dynamic> json) => _$Yahoo_calenderEventsFromJson(json);
    Map<String, dynamic> toJson() => _$Yahoo_calenderEventsToJson(this);
}
