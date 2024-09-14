import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  bool _inProgress = false;
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productImageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            'Add New Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildAddNewProductForm(),
        ),
      ),
    );
  }
  Widget _buildAddNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _productNameTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Product Name'),
                hintText: 'Product Name'
            ),
          ),
          TextFormField(
            controller: _unitPriceTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Unit Price'),
                hintText: 'Unit Price'
            ),
          ),
          TextFormField(
            controller: _totalPriceTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Total Price'),
                hintText: 'Total Price'
            ),
          ),
          TextFormField(
            controller: _productImageTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Product Image'),
                hintText: 'Product Image'
            ),
          ),
          TextFormField(
            controller: _productCodeTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Product Code'),
                hintText: 'Product Code'
            ),
          ),
          TextFormField(
            controller: _quantityTEController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            decoration: const InputDecoration(
                label: Text('Quantity'),
                hintText: 'Quantity'
            ),
          ),
          const SizedBox(height: 20),
          _inProgress ? const Center(
            child: CircularProgressIndicator(),
          ): ElevatedButton(
              onPressed: _onTapAddProductButton,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              elevation: 5,
              minimumSize: const Size(double.infinity, 44),
            ),
              child: const Text(
                  "Add Product",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
        ],
      ),
    );
  }

  void _onTapAddProductButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/CreateProduct");
    Map<String, dynamic> requestBody = {
      "Img": _productImageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _productNameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    Response response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      textClearFields();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
          content: Text("Added new item"),
      ));
    }
    _inProgress = false;
    setState(() {});
  }

  void textClearFields() {
    _productNameTEController.clear();
    _unitPriceTEController.clear();
    _totalPriceTEController.clear();
    _productImageTEController.clear();
    _productCodeTEController.clear();
    _quantityTEController.clear();
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _unitPriceTEController.dispose();
    _totalPriceTEController.dispose();
    _productImageTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}
