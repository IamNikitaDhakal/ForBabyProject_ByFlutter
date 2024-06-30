// ignore_for_file: unused_element, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterproject/Components/colors.dart';
import 'package:flutterproject/JSON/items.dart';
import 'package:flutterproject/SQLite/item_db.dart';
import 'package:flutterproject/Views/form_page.dart';
import 'package:flutterproject/Views/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Item> items = [];
  final ItemDB itemDB = ItemDB();

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final fetchedItems = await itemDB.fetchAll();
    setState(() {
      items = fetchedItems;
    });
  }

  Future<void> _editItem(Item item) async {
    final bool? formSubmitted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(item: item),
      ),
    );
    if (formSubmitted == true) {
      _fetchItems();
    }
  }

  Future<void> _markAsPurchased(Item item) async {
    try {
      await itemDB.markAsPurchased(item.id);
      _fetchItems(); // Refresh items after marking as purchased
      print('Item with ID ${item.id} marked as purchased.');
    } catch (e) {
      print('Error marking item as purchased: $e');
      // Handle error: Display a message to the user or perform appropriate actions
    }
  }

  void _deleteItem(Item item) async {
    await itemDB.delete(item.id); // Correct usage of delete method
    _fetchItems(); // Refresh items after deletion
  }

  Future<bool?> _showDeleteConfirmationDialog(Item item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${item.productName}?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return confirmed;
  }

  Future<bool?> _showMarkAsPurchasedDialog(Item item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Purchased'),
        content:
            const Text('Are you sure you want to mark this item as purchased?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, true);
              _markAsPurchased(item);
            },
            child: const Text('Mark as Purchased'),
          ),
        ],
      ),
    );
    return confirmed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0),
          children: <Widget>[
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: submitcolor,
              ),
              child: const Center(
                child: Text(
                  'Get Connect with us',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(
                  context,
                  '/about',
                ); // Navigate to AboutUsPage
              },
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/faqs');
              },
            ),
            ListTile(
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              title: const Text('Updates and News'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/updates_and_news');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item.id.toString()),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return await _showDeleteConfirmationDialog(item);
              } else if (direction == DismissDirection.endToStart) {
                await _showMarkAsPurchasedDialog(item);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }

              return false;
            },
            onDismissed: (direction) {
              setState(() {
                if (direction == DismissDirection.startToEnd) {
                  _deleteItem(item); // Example method to delete item
                } else if (direction == DismissDirection.endToStart) {
                  _markAsPurchased(
                      item); // Example method to mark item as purchased
                }
                items.removeAt(index); // Remove item from the list
              });
            },
            child: ListTile(
              title: Text(item.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expected Price: ${item.expectedPrice}'),
                  Text('Description: ${item.productDescription}'),
                  Text('Location: ${item.productLocation}'),
                ],
              ),
              leading: item.imagePath != null
                  ? Image.file(
                      File(item.imagePath!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : null,
              trailing: item.isPurchased
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? formSubmitted = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
          if (formSubmitted == true) {
            _fetchItems();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
