import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutterproject/SQLite/database_service.dart';
import 'package:flutterproject/JSON/items.dart';

class ItemDB {
  final String tableName = 'items';

  Future<void> createTable(Database database) async {
    await database.execute(
      '''CREATE TABLE IF NOT EXISTS $tableName (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "productName" TEXT NOT NULL,
        "expectedPrice" REAL NOT NULL,
        "productDescription" TEXT NOT NULL,
        "productLocation" TEXT NOT NULL,
        "imagePath" TEXT,  // New column for image path
        "createdAt" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as INTEGER)),
        "updatedAt" INTEGER
      );''',
    );
  }

  Future<int> create({
    required String productName,
    required double expectedPrice,
    required String productDescription,
    required String productLocation,
    String? imagePath, // New parameter for image path
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (productName, expectedPrice, productDescription, productLocation, imagePath, createdAt) VALUES (?, ?, ?, ?, ?, ?)''',
      [
        productName,
        expectedPrice,
        productDescription,
        productLocation,
        imagePath, // Insert image path
        DateTime.now().millisecondsSinceEpoch,
      ],
    );
  }

  // Fetch methods remain the same

  Future<int> update({
    required int id,
    String? productName,
    double? expectedPrice,
    String? productDescription,
    String? productLocation,
    String? imagePath, // New parameter for image path
  }) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (productName != null) 'productName': productName,
        if (expectedPrice != null) 'expectedPrice': expectedPrice,
        if (productDescription != null)
          'productDescription': productDescription,
        if (productLocation != null) 'productLocation': productLocation,
        if (imagePath != null) 'imagePath': imagePath, // Update image path
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<List<Item>> fetchAll() async {
    final database = await DatabaseService().database;
    final items = await database.query(tableName);
    return items.map((item) => Item.fromMap(item)).toList();
  }

  // Method to pick an image from device storage
  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return null;
  }
}
