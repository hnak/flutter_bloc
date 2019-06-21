import 'dart:async';

import 'package:bloc_complex/models/cart_item.dart';
import 'package:bloc_complex/models/product.dart';
import 'package:bloc_complex/services/cart.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class CartAddition {
  final Product product;
  final int count;

  const CartAddition(this.product, {this.count = 1});
}

@immutable
class CartBloc implements Bloc {
  static const _cart = CartService();

  final _items = BehaviorSubject<List<CartItem>>.seeded([]);
  final _itemCount = BehaviorSubject<int>.seeded(0);
  final _cartAdditionController = StreamController<CartAddition>();

  CartBloc() {
    _cartAdditionController.stream.listen((addition) {
      _cart.add(addition.product, addition.count);
      _items.add(_cart.items);
      _itemCount.add(_cart.itemCount);
    });
  }

  Sink<CartAddition> get cartAdditionSink => _cartAdditionController.sink;

  ValueObservable<int> get itemCountStream =>
      _itemCount.distinct().shareValueSeeded(0);

  ValueObservable<List<CartItem>> get itemsStream => _items.stream;

  @override
  void dispose() {
    _items.close();
    _itemCount.close();
    _cartAdditionController.close();
  }
}
