// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:flutterproject/JSON/items.dart';

class ItemDB {
  static List<Item> _items = []; // Assuming this list holds your items

  Future<List<Item>> fetchAll() async {
    await Future.delayed(const Duration(seconds: 0)); // Simulate delay
    return _items.toList(); // Return a copy of items list
  }

  Future<void> create({
    required String productName,
    required double expectedPrice,
    required String productDescription,
    required String productLocation,
    String? imagePath,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    final newItem = Item(
      id: _items.length + 1,
      productName: productName,
      expectedPrice: expectedPrice,
      productDescription: productDescription,
      productLocation: productLocation,
      imagePath: imagePath,
    );
    _items.add(newItem);
    print('Item created: $newItem');
  }

  Future<void> update(
    Item item, {
    required int id,
    required String productName,
    required double expectedPrice,
    required String productDescription,
    required String productLocation,
    String? imagePath,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final updatedItem = Item(
        id: id,
        productName: productName,
        expectedPrice: expectedPrice,
        productDescription: productDescription,
        productLocation: productLocation,
        imagePath: imagePath,
      );
      _items[index] = updatedItem;
      print('Item updated: $updatedItem');
    } else {
      print('Item with ID $id not found.');
    }
  }

  Future<void> delete(int id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final deletedItem = _items.removeAt(index);
      print('Item deleted: $deletedItem');
    } else {
      print('Item with ID $id not found.');
    }
  }

  Future<void> markAsPurchased(int id) async {
    try {
      final index = _items.indexWhere((item) => item.id == id);
      if (index != -1) {
        _items[index].isPurchased = true;
        // Update the item in the database or storage here

        print('Item marked as purchased: ${_items[index]}');
      } else {
        print('Item with ID $id not found.');
      }
    } catch (e) {
      print('Error marking item as purchased: $e');
      throw Exception('Failed to mark item as purchased');
    }
  }

  deleteItem(int id) {}
}
