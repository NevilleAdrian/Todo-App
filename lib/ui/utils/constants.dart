//header
Map<String, String> _headers() {
  return {
    'Content-type': 'application/json',
    "x-rapidapi-host": "covid-193.p.rapidapi.com",
    'x-rapidapi-key': '2d78657075mshbed8218402749ccp14a10ejsn18b94aa44e9b'
  };
}

const kHeaders = _headers;

//url
const String kUrl = 'covid-193.p.rapidapi.com';

//hiveData constants
const String kCountryStatistics = 'countryStatistics';
const String kTasks = 'tasks';
