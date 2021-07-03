import 'package:flutter/cupertino.dart';
import 'package:morphosis_flutter_demo/non_ui/model/statistics.dart';
import 'package:morphosis_flutter_demo/non_ui/model/task.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/auth_provider.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

class FilterHelper {
  List<GetCountriesStatistics> filteredSearch = [];
  List<GetCountriesStatistics> countries = [];
  List<Task> task;

//Future helpers
  Future<List<GetCountriesStatistics>> futureTasks(BuildContext context) async {
    countries = await Auth.authProvider(context).getCountryStatistics(context);
    filteredSearch = Auth.authProvider(context).countriesStats;
    return Future.value(countries);
  }

  Future<List<Task>> futureFirebaseTask(BuildContext context) async {
    task = await FirebaseManager.fireBaseProvider(context).taskManager(context);
    return Future.value(task);
  }
  // end

  List<GetCountriesStatistics> onFilter(String term, BuildContext context) {
    return Auth.authProvider(context)
        .countriesStats
        .where((element) =>
            element.country.toLowerCase().startsWith(term.toLowerCase()) ??
            false)
        .toList();
  }
}
