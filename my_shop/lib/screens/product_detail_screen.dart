import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // const ProductDetailScreen(this.title);
  static const routName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('this.title'),
      ),
    );
  }
}
