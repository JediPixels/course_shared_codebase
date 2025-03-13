class ApiUrl {
  static const String _apiBaseUrl = 'https://dummyjson.com';
  static const String _apiQueryUrl =
      'users?limit=50&skip=0&select=id,firstName,lastName,email,university,image';
  static const String apiBaseAndQueryUrl = '$_apiBaseUrl/$_apiQueryUrl';
}
