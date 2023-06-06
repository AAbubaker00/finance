import 'package:json_annotation/json_annotation.dart';

part 'yahoo_assets_results.g.dart';

class Yahoo_assets_results {
    Yahoo_assets_results();

    String address1;
    String city;
    String zip;
    String country;
    String phone;
    String website;
    String industry;
    String sector;
    String longBusinessSummary;
    num fullTimeEmployees;
    List companyOfficers;
    num auditRisk;
    num boardRisk;
    num compensationRisk;
    num shareHolderRightsRisk;
    num overallRisk;
    num governanceEpochDate;
    num compensationAsOfEpochDate;
    num maxAge;
    
    factory Yahoo_assets_results.fromJson(Map<String,dynamic> json) => _$Yahoo_assets_resultsFromJson(json);
    Map<String, dynamic> toJson() => _$Yahoo_assets_resultsToJson(this);
}
