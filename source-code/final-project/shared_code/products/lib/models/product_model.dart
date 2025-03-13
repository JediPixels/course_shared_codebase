import 'dart:convert';

class ProductModel {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
    required this.images,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Product.blankDefaultValues() {
    return Product(
      id: 0,
      title: '',
      price: 0.0,
      rating: 0.0,
      category: '',
      images: [],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        category: json["category"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "rating": rating,
        "category": category,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

// JSON Sample
// {
//   "products": [
//     {
//       "id": 1,
//       "title": "iPhone 9",
//       "price": 549,
//       "rating": 4.69,
//       "category": "smartphones",
//       "images": [
//         "https://i.dummyjson.com/data/products/1/1.jpg",
//         "https://i.dummyjson.com/data/products/1/2.jpg",
//         "https://i.dummyjson.com/data/products/1/3.jpg",
//         "https://i.dummyjson.com/data/products/1/4.jpg",
//         "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
//       ]
//     },
//     {
//       "id": 2,
//       "title": "iPhone X",
//       "price": 899,
//       "rating": 4.44,
//       "category": "smartphones",
//       "images": [
//       "https://i.dummyjson.com/data/products/2/1.jpg",
//       "https://i.dummyjson.com/data/products/2/2.jpg",
//       "https://i.dummyjson.com/data/products/2/3.jpg",
//       "https://i.dummyjson.com/data/products/2/thumbnail.jpg"
//       ]
//     }
//   ],
//   "total": 100,
//   "skip": 0,
//   "limit": 2
// }
