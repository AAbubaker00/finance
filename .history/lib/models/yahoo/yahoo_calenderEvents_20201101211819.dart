import 'package:json_annotation/json_annotation.dart';

part '../yahoo_calenderEvents.g.dart';

@JsonSerializable()
class Yahoo_calenderEvents {
    Yahoo_calenderEvents();

    Map<String,dynamic> calendarEvents;
    
    factory Yahoo_calenderEvents.fromJson(Map<String,dynamic> json) => _$Yahoo_calenderEventsFromJson(json);
    Map<String, dynamic> toJson() => _$Yahoo_calenderEventsToJson(this);
}
