import 'package:bloc_complex/bloc/cart/cart_provider.dart';
import 'package:bloc_complex/bloc/product/product_square_bloc.dart';
import 'package:bloc_complex/models/product.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';

@immutable
class ProductSquareProvider extends BlocProvider<ProductSquareBloc> {
  final Product product;
  ProductSquareProvider({
    @required this.product,
    @required BlocBuilder<ProductSquareBloc> builder,
  }) : super.builder(
          creator: (context, bag) {
            final cartBloc = CartProvider.of(context);
            final bloc = ProductSquareBloc(product);
            final subscription =
                cartBloc.itemsStream.listen(bloc.cartItemsSink.add);
            bag.register(onDisposed: subscription.cancel);
            return bloc;
          },
          builder: builder,
        );
  static ProductSquareBloc of(BuildContext context) => BlocProvider.of(context);
}
