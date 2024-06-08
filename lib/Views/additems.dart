import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutterproject/JSON/items.dart';

class AddItems extends StatefulWidget {
  final Item? item;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const AddItems({
    super.key,
    this.item,
    required this.onSubmit,
  });

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _expectedPriceController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productLocationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _productNameController.text = widget.item!.productName;
      _expectedPriceController.text = widget.item!.expectedPrice.toString();
      _productDescriptionController.text = widget.item!.productDescription;
      _productLocationController.text = widget.item!.productLocation;
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Item' : 'Add Item'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Product Name is required'
                    : null,
              ),
              TextFormField(
                controller: _expectedPriceController,
                decoration: const InputDecoration(labelText: 'Expected Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value != null && value.isEmpty
                    ? 'Expected Price is required'
                    : null,
              ),
              TextFormField(
                controller: _productDescriptionController,
                decoration:
                    const InputDecoration(labelText: 'Product Description'),
              ),
              TextFormField(
                controller: _productLocationController,
                decoration:
                    const InputDecoration(labelText: 'Product Location'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final formData = {
                'productName': _productNameController.text,
                'expectedPrice':
                    double.tryParse(_expectedPriceController.text) ?? 0.0,
                'productDescription': _productDescriptionController.text,
                'productLocation': _productLocationController.text,
              };
              widget.onSubmit(formData);
              Navigator.pop(context);
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
