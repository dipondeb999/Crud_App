import 'dart:convert';
import 'package:crud_app/presentation/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;
  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool _inProgress = false;
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productImageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _productNameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice.toString();
    _totalPriceTEController.text = widget.product.totalPrice.toString();
    _productImageTEController.text = widget.product.productImage;
    _productCodeTEController.text = widget.product.productCode;
    _quantityTEController.text = widget.product.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _inProgress ? const Center(
            child: CircularProgressIndicator()) : _buildUpdateProductForm(),
      ),
    );
  }

  Widget _buildUpdateProductForm() {
    return SingleChildScrollView(
      child: Form(
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
                  labelText: 'Product Name',
                  hintText: 'Product Name',
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
                  labelText: 'Unit Price',
                  hintText: 'Unit Price',
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
                  labelText: 'Total Price',
                  hintText: 'Total Price',
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
                  labelText: 'Product Image',
                  hintText: 'Product Image',
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
                  labelText: 'Product Code',
                  hintText: 'Product Code',
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
                  labelText: 'Quantity',
                  hintText: 'Quantity',
              ),
            ),
            const SizedBox(height: 20),
            _inProgress ? const Center(
              child: CircularProgressIndicator(),
            ): ElevatedButton(
              onPressed: _onTapUpdateProductButton,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                elevation: 5,
                minimumSize: const Size(double.infinity, 44),
              ),
              child: const Text(
                "Update",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapUpdateProductButton() {
    if (_formKey.currentState!.validate()) {
      updateProduct();
    }
  }

  Future<void> updateProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.product.id}");
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
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Product updated successfully!"),
      ));
      Navigator.pop(context);
    }
    _inProgress = false;
    setState(() {});
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

