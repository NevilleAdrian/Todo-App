import 'package:hive/hive.dart';

part 'statistics.g.dart';

@HiveType(typeId: 1)
class GetCountriesStatistics {
  GetCountriesStatistics({
    this.continent,
    this.country,
    this.population,
    this.cases,
  });

  @HiveField(0)
  String continent;
  @HiveField(1)
  String country;
  @HiveField(2)
  int population;
  @HiveField(3)
  Cases cases;

  factory GetCountriesStatistics.fromJson(Map<String, dynamic> json) =>
      GetCountriesStatistics(
        continent: json["continent"],
        country: json["country"],
        population: json["population"],
        cases: Cases.fromJson(json["cases"]),
      );

  Map<String, dynamic> toJson() => {
        "continent": continent,
        "country": country,
        "population": population,
        "cases": cases.toJson(),
      };
}

@HiveType(typeId: 2)
class Cases {
  Cases({
    this.casesNew,
    this.active,
    this.critical,
    this.recovered,
    this.the1MPop,
    this.total,
  });

  @HiveField(0)
  String casesNew;
  @HiveField(1)
  int active;
  @HiveField(2)
  int critical;
  @HiveField(3)
  int recovered;
  @HiveField(4)
  String the1MPop;
  @HiveField(5)
  int total;

  factory Cases.fromJson(Map<String, dynamic> json) => Cases(
        casesNew: json["new"],
        active: json["active"],
        critical: json["critical"],
        recovered: json["recovered"],
        the1MPop: json["1M_pop"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "new": casesNew,
        "active": active,
        "critical": critical,
        "recovered": recovered,
        "1M_pop": the1MPop,
        "total": total,
      };
}
