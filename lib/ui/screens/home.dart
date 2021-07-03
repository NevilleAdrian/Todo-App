import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/model/statistics.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/auth_provider.dart';
import 'package:morphosis_flutter_demo/ui/utils/functions.dart';
import 'package:morphosis_flutter_demo/ui/widgets/future_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchTextField = TextEditingController();
  FilterHelper filterHelper = FilterHelper();

  Future<List<GetCountriesStatistics>> futureGetCountryStatistics;

  //Utility functions

  onSearch() {
    List<GetCountriesStatistics> countries =
        Auth.authProvider(context).countriesStats;
    setState(() {
      filterHelper.filteredSearch =
          filterHelper.onFilter(_searchTextField.text, context);
    });
  }

  @override
  void initState() {
    futureGetCountryStatistics = filterHelper.futureTasks(context);

    _searchTextField.addListener(onSearch);
    super.initState();
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final conuntryStats = Auth.authProvider(context).countriesStats;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height,
        width: size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* In this section we will be testing your skills with network and local storage. You need to fetch data from any open source api from the internet.
             E.g:
             https://any-api.com/
             https://rapidapi.com/collection/best-free-apis?utm_source=google&utm_medium=cpc&utm_campaign=Beta&utm_term=%2Bopen%20%2Bsource%20%2Bapi_b&gclid=Cj0KCQjw16KFBhCgARIsALB0g8IIV107-blDgIs0eJtYF48dAgHs1T6DzPsxoRmUHZ4yrn-kcAhQsX8aAit1EALw_wcB
             Implement setup for network. You are free to use package such as Dio, Choppper or Http can ve used as well.
             Upon fetching the data try to store thmm locally. You can use any local storeage.
             Upon Search the data should be filtered locally and should update the UI.
            */

            CupertinoSearchTextField(
              key: Key('searchKey'),
              controller: _searchTextField,
            ),
            SizedBox(
              height: 10,
            ),
            FutureHelper<List<GetCountriesStatistics>>(
              task: futureGetCountryStatistics,
              loader: CountryStatisticsScreen(
                  countryStats: filterHelper.filteredSearch.isEmpty
                      ? conuntryStats
                      : filterHelper.filteredSearch),
              builder: (context, _) {
                return CountryStatisticsScreen(
                    countryStats: filterHelper.filteredSearch.isEmpty
                        ? conuntryStats
                        : filterHelper.filteredSearch);
              },
              noData: Text(
                "Call any api you like from open apis and show them in a list. ",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryStatisticsScreen extends StatelessWidget {
  const CountryStatisticsScreen({
    Key key,
    @required this.countryStats,
  }) : super(key: key);

  final List<GetCountriesStatistics> countryStats;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: countryStats == null
          ? CircularProgress()
          : ListView.builder(
              itemCount: countryStats.length,
              itemBuilder: (BuildContext context, int index) {
                final statistics = countryStats[index];
                return Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Text(statistics.country))
                  ],
                );
              }),
    );
  }
}

class CircularProgress extends StatelessWidget {
  const CircularProgress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 7,
        ),
        width: 60,
        height: 60,
      ),
    );
  }
}
