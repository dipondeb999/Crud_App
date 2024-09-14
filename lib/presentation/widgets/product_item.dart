import 'package:crud_app/presentation/models/product.dart';
import 'package:crud_app/presentation/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final List<Product> productList;
  final int index;

  const ProductItem({
    super.key,
    required this.product,
    required this.productList,
    required this.index,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.deepPurple,
        title: Text(
          widget.product.productName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Code: ${widget.product.productCode}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "Price: \$${widget.product.unitPrice}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "Quantity: ${widget.product.quantity}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "Total Price: \$${widget.product.totalPrice}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const Divider(),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return ButtonBar(
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProductScreen(
                  product: widget.product,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: const Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            _onTapDeleteProduct(widget.product, widget.index);
            },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          label: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onTapDeleteProduct(Product product, int index) async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse("http://164.68.107.70:6060/api/v1/DeleteProduct/${product.id}");
    Response response = await delete(uri);
    if (response.statusCode == 200) {
      widget.productList.removeAt(index);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Product deleted successfully"),
        ),
      );
    }
    _inProgress = false;
    setState(() {});
  }
}
