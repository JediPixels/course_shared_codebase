import 'package:http/http.dart' as http;

/// API Service
class APIService {
  /// Retrieve Search [urlPathParameters] via Parse
  static Future<String> getSearch(
    String urlPathParameters,
  ) async {
    Uri url = Uri.parse(urlPathParameters);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      return Future.error('Failed to load:\n404 Not Found');
    } else {
      return Future.error('Failed to load:\nUnknown Error');
    }
  }
}
