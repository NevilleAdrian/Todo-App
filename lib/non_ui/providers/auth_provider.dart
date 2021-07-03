import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morphosis_flutter_demo/non_ui/Exceptions/api_failure_exception.dart';
import 'package:morphosis_flutter_demo/non_ui/helpers/network_helper.dart';
import 'package:morphosis_flutter_demo/non_ui/model/statistics.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/hive/hive_repository.dart';
import 'package:morphosis_flutter_demo/ui/utils/constants.dart';
import 'package:morphosis_flutter_demo/ui/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class Auth extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();

  List<GetCountriesStatistics> _countriesStats;
  PageController _pageController;

  List<GetCountriesStatistics> get countriesStats => _countriesStats;
  PageController get pageController => _pageController;

  static BuildContext _context;

  setCountryStatistics(List<GetCountriesStatistics> countriesStats) =>
      _countriesStats = countriesStats;

  setPageController(PageController controller) => _pageController = controller;

  static Auth authProvider(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<Auth>(context, listen: listen);
  }

  Future<List<GetCountriesStatistics>> getCountryStatistics(
      BuildContext context) async {
    try {
      //Call NetworkHelper to make Api call
      var data = await _helper.getCountryStatistics();

      // Convert dynamic data to GetCountriesStatistics model
      data = (data as List)
          .map((e) => GetCountriesStatistics.fromJson(e))
          .toList();

      //Set data to list of GetCountriesStatistics
      setCountryStatistics(data);

      //Save data in hive
      _hiveRepository.add<List<GetCountriesStatistics>>(
          name: kCountryStatistics, key: 'countryStatistics', item: data);

      //Return data
      return data;
    } catch (ex) {
      showFlush(context, ex.toString());
      //Exception throw
      throw ApiFailureException(ex);
    }
  }
}
