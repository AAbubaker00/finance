import 'package:json_annotation/json_annotation.dart';

class Yahoo_Assets_Results {
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

  Yahoo_Assets_Results({
    this.address1,
    this.city,
    this.zip,
    this.country,
    this.phone,
    this.website,
    this.industry,
    this.sector,
    this.longBusinessSummary,
    this.fullTimeEmployees,
    this.companyOfficers,
    this.auditRisk,
    this.boardRisk,
    this.compensationRisk,
    this.shareHolderRightsRisk,
    this.overallRisk,
    this.governanceEpochDate,
    this.compensationAsOfEpochDate,
    this.maxAge,
  });


  Yahoo_Assets_Results.fromJson(Map<String, dynamic> assetsJson)
  ..address1 = json['address1'] as String
    ..city = json['city'] as String
    ..zip = json['zip'] as String
    ..country = json['country'] as String
    ..phone = json['phone'] as String
    ..website = json['website'] as String
    ..industry = json['industry'] as String
    ..sector = json['sector'] as String
    ..longBusinessSummary = json['longBusinessSummary'] as String
    ..fullTimeEmployees = json['fullTimeEmployees'] as num
    ..companyOfficers = json['companyOfficers'] as List
    ..auditRisk = json['auditRisk'] as num
    ..boardRisk = json['boardRisk'] as num
    ..compensationRisk = json['compensationRisk'] as num
    ..shareHolderRightsRisk = json['shareHolderRightsRisk'] as num
    ..overallRisk = json['overallRisk'] as num
    ..governanceEpochDate = json['governanceEpochDate'] as num
    ..compensationAsOfEpochDate = json['compensationAsOfEpochDate'] as num
    ..maxAge = json['maxAge'] as num;
}
