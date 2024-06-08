// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutterproject/Components/colors.dart';
import 'package:flutterproject/Views/profile.dart';
import 'package:flutterproject/Views/additems.dart';
import 'package:flutterproject/JSON/items.dart';
import 'package:flutterproject/SQLite/additem_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Item> items;
  final ItemDB itemDB = ItemDB();

  @override
  void initState() {
    super.initState();
    items = [];
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final fetchedItems = await itemDB.fetchAll();
    setState(() {
      items = fetchedItems;
    });
  }

  void _handleSubmit(Map<String, dynamic> formData) async {
    if (formData['id'] != null) {
      await itemDB.update(
        id: formData['id'],
        productName: formData['productName'],
        expectedPrice: formData['expectedPrice'],
        productDescription: formData['productDescription'],
        productLocation: formData['productLocation'],
      );
    } else {
      await itemDB.create(
        productName: formData['productName'],
        expectedPrice: formData['expectedPrice'],
        productDescription: formData['productDescription'],
        productLocation: formData['productLocation'],
      );
    }
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.productName),
            subtitle: Text('Expected Price: ${item.expectedPrice}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AddItems(
                  item: item,
                  onSubmit: (formData) {
                    formData['id'] = item.id;
                    _handleSubmit(formData);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddItems(
              onSubmit: _handleSubmit,
            ),
          );
        },
        backgroundColor: submitcolor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
