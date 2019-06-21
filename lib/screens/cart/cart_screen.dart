import 'package:bloc_complex/bloc/cart/cart_provider.dart';
import 'package:bloc_complex/models/cart_item.dart';
import 'package:bloc_complex/widgets/cart_page.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen();

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: cart.itemsStream,
        builder: (context, snapshot) {
          if (snapshot.data?.isEmpty ?? true) {
            return Center(
              child: Text('Empty', style: Theme.of(context).textTheme.display1),
            );
          }

          return ListView(
            children:
                snapshot.data.map((item) => ItemTile(item: item)).toList(),
          );
        },
      ),
    );
  }
}
