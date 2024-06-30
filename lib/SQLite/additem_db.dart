import 'package:sqflite/sqflite.dart';
import 'package:flutterproject/SQLite/database_service.dart';

class ItemDB {
  static Future<void> createTable(Database db) async {
    await db.execute(
      'CREATE TABLE items('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'productName TEXT, '
      'expectedPrice REAL, '
      'productDescription TEXT, '
      'productLocation TEXT, '
      'imagePath TEXT, '
      'isPurchased INTEGER DEFAULT 0' // Added column for marking purchased
      ')',
    );
  }

  Future<List<Item>> fetchAll() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        productName: maps[i]['productName'],
        expectedPrice: maps[i]['expectedPrice'],
        productDescription: maps[i]['productDescription'],
        productLocation: maps[i]['productLocation'],
        imagePath: maps[i]['imagePath'],
        isPurchased: maps[i]['isPurchased'] == 1, // Convert to bool
      );
    });
  }

  Future<void> createItem(Item newItem) async {
    final db = await DatabaseService().database;
    await db.insert(
      'items',
      newItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(Item newItem) async {
    final db = await DatabaseService().database;
    await db.update(
      'items',
      newItem.toMap(),
      where: 'id = ?',
      whereArgs: [newItem.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await DatabaseService().database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAsPurchased(int id) async {
    final db = await DatabaseService().database;
    await db.update(
      'items',
      {'isPurchased': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Item {
  final int? id;
  final String productName;
  final double expectedPrice;
  final String productDescription;
  final String productLocation;
  final String? imagePath;
  bool isPurchased;

  Item({
    this.id,
    required this.productName,
    required this.expectedPrice,
    required this.productDescription,
    required this.productLocation,
    this.imagePath,
    this.isPurchased = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'expectedPrice': expectedPrice,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'imagePath': imagePath,
      'isPurchased': isPurchased ? 1 : 0, // Convert bool to integer for SQLite
    };
  }
}
