import 'package:flutter_test/flutter_test.dart';
import 'package:shared/services/api_service.dart';

void main() {
  test('retrieve json', () async {
    final response = await APIService.getSearch(
      'https://dummyjson.com/users?limit=2&skip=0&select=id,firstName,lastName,email,image',
      // 'users',
      // api,
    );

    expect(
      response,
      '{"users":[{"id":1,"firstName":"Terry","lastName":"Medhurst","email":"atuny0@sohu.com","image":"https://robohash.org/hicveldicta.png"},{"id":2,"firstName":"Sheldon","lastName":"Quigley","email":"hbingley1@plala.or.jp","image":"https://robohash.org/doloremquesintcorrupti.png"}],"total":100,"skip":0,"limit":2}',
    );
  });
}
