import 'dart:convert';

/// User Model
class UserModel {
  List<User> users;
  int total;
  int skip;
  int limit;

  UserModel({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String university;
  final String image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.university,
    required this.image,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory User.blankDefaultValues() {
    return User(
      id: 0,
      firstName: '',
      lastName: '',
      email: '',
      university: '',
      image: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        university: json["university"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "university": university,
        "image": image,
      };
}

// JSON Sample
// {
//   "users": [
//    {
//      "id": 2,
//      "firstName": "Sheldon",
//      "lastName": "Quigley",
//      "email": "hbingley1@plala.or.jp",
//      "university": "Stavropol State Technical University",
//      "image": "https://robohash.org/doloremquesintcorrupti.png"
//    },
//    {
//      "id": 3,
//      "firstName": "Terrill",
//      "lastName": "Hills",
//      "email": "rshawe2@51.la",
//      "university": "University of Cagayan Valley",
//      "image": "https://robohash.org/consequunturautconsequatur.png"
//    }
//   ],
//   "total": 100,
//   "skip": 1,
//   "limit": 2
// }
