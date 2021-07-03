import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:morphosis_flutter_demo/ui/utils/constants.dart';

import '../Exceptions/api_failure_exception.dart';

/// Helper class to make http request

uriConverter(String url) {
  return Uri.https(kUrl, '$url');
}

class NetworkHelper {
  Future<dynamic> getCountryStatistics() async {
    final result = await getRequest('statistics');
    if (result['status'] != null && !result['status']) {
      throw ApiFailureException(result['message']);
    }
    return result['response'];
  }

  Future<dynamic> getRequest(String url) async {
    var response = await http.get(uriConverter(url), headers: kHeaders());
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }
}
