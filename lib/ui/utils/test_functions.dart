import 'package:morphosis_flutter_demo/non_ui/model/statistics.dart';

List<GetCountriesStatistics> countriesStats = [
  GetCountriesStatistics(country: 'Billy'),
  GetCountriesStatistics(country: 'Jones')
];

String onFilter(String term) {
  countriesStats
      .where((element) =>
          element.country.toLowerCase().startsWith(term.toLowerCase()) ?? false)
      .toList();
  return countriesStats.first.country;
}
