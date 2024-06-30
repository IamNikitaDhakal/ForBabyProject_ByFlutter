// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterproject/JSON/items.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterproject/SQLite/item_db.dart';
import 'package:flutterproject/Components/colors.dart';

class FormPage extends StatefulWidget {
  final Item? item; // Optional item parameter for editing

  const FormPage({super.key, this.item});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _expectedPriceController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productLocationController =
      TextEditingController();
  File? _imageFile;
  bool _imagePicked = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePicked = true;
      });
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitForm() async {
    final productName = _productNameController.text;
    final expectedPrice = _expectedPriceController.text;
    final productDescription = _productDescriptionController.text;
    final productLocation = _productLocationController.text;
    final imagePath = _imageFile?.path ?? '';

    if (productName.isEmpty ||
        expectedPrice.isEmpty ||
        productDescription.isEmpty ||
        productLocation.isEmpty ||
        imagePath.isEmpty) {
      _showErrorMessage('Some fields are missing');
      return;
    }

    final ItemDB itemDB = ItemDB();
    final formData = {
      'productName': productName,
      'expectedPrice': double.tryParse(expectedPrice) ?? 0.0,
      'productDescription': productDescription,
      'productLocation': productLocation,
      'imageFile': imagePath,
    };

    await itemDB.create(
      productName: formData['productName'] as String,
      expectedPrice:
          double.tryParse(formData['expectedPrice'].toString()) ?? 0.0,
      productDescription: formData['productDescription'] as String,
      productLocation: formData['productLocation'] as String,
      imagePath: formData['imageFile'] as String?,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss the keyboard when tapping outside
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              if (_imageFile != null) ...[
                Image.file(_imageFile!,
                    width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(height: 20),
              ],
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  decoration: BoxDecoration(
                    color: textfieldcolor,
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.image, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        _imagePicked ? 'Replace Image' : 'Add Image',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: textfieldcolor,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    alignLabelWithHint: true,
                    border: InputBorder.none, // No visible border
                    contentPadding: EdgeInsets.zero, // Remove default padding
                    hintStyle: TextStyle(
                        color: Colors.grey), // Optional: Style for hint text
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black), // Text color of the input
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: textfieldcolor,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _expectedPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Expected Price',
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: Colors.grey),
                    floatingLabelBehavior:
                        FloatingLabelBehavior.auto, // Enable floating label
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: textfieldcolor,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _productDescriptionController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: textfieldcolor,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: _productLocationController,
                  decoration: const InputDecoration(
                    labelText: 'Product Location',
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: submitcolor,
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
