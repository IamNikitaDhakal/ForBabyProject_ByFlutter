import 'dart:io';

class Item {
  int? id;
  final String productName;
  final double expectedPrice;
  final String productDescription;
  final String productLocation;
  final String imagePath; // Updated to non-nullable
  final String createdAt;
  final String? updatedAt;

  Item({
    required this.id,
    required this.productName,
    required this.expectedPrice,
    required this.productDescription,
    required this.productLocation,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'expectedPrice': expectedPrice,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) => Item(
        id: map['id'],
        productName: map['productName'],
        expectedPrice: map['expectedPrice'],
        productDescription: map['productDescription'],
        productLocation: map['productLocation'],
        imagePath: map['imagePath'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
      );
}
