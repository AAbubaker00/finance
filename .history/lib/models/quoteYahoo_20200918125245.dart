import 'package:json_annotation/json_annotation.dart';

part 'quoteYahoo.g.dart';

@JsonSerializable()
class QuoteYahoo {
    QuoteYahoo();

    Map<String,$response> quoteResponse;
    
    factory QuoteYahoo.fromJson(Map<String,dynamic> json) => _$QuoteYahooFromJson(json);
    Map<String, dynamic> toJson() => _$QuoteYahooToJson(this);
}
