class Item {
  final int id;
  final String productName;
  final double expectedPrice;
  final String productDescription;
  final String productLocation;
  final String? imagePath; // Optional

  Item({
    required this.id,
    required this.productName,
    required this.expectedPrice,
    required this.productDescription,
    required this.productLocation,
    this.imagePath,
  });
}
