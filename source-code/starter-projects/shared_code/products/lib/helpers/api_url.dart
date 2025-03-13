class ApiUrl {
  static const String _apiBaseUrl = 'https://dummyjson.com';
  static const String _apiQueryUrl =
      'products?limit=50&skip=0&select=title,price,rating,category,images';
  static const String apiBaseAndQueryUrl = '$_apiBaseUrl/$_apiQueryUrl';
}
