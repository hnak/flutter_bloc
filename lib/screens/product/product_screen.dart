import 'package:bloc_complex/bloc/cart/cart_provider.dart';
import 'package:bloc_complex/screens/cart/cart_screen.dart';
import 'package:bloc_complex/screens/product/cart_button.dart';
import 'package:bloc_complex/screens/product/product_grid.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen();

  static const routeName = '/product';
  static const title = Text('Product');

  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Complex'),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCountStream,
            initialData: cartBloc.itemCountStream.value,
            builder: (context, snapshot) => CartButton(
                  itemCount: snapshot.data,
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
