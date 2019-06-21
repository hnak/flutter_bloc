import 'package:bloc_complex/bloc/cart/cart_provider.dart';
import 'package:bloc_complex/bloc/catalog/catalog_provider.dart';
import 'package:bloc_complex/bloc/login/login_provider.dart';
import 'package:bloc_complex/screens/cart/cart_screen.dart';
import 'package:bloc_complex/screens/login/login_screen.dart';
import 'package:bloc_complex/screens/product/product_screen.dart';
import 'package:bloc_complex/services/service_provider.dart';
import 'package:bloc_complex/widgets/theme.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

import 'services/catalog.dart';

void main() {
  runApp(
    const ServiceProvider(
      catalogService: CatalogService(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App();
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        CatalogProvider(),
        CartProvider(),
        LoginProvider(),
      ],
      child: MaterialApp(
        title: 'Bloc Complex',
        theme: appTheme,
        home: const LoginScreen(),
        routes: {
          CartScreen.routeName: (context) => const CartScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          ProductScreen.routeName: (context) => const ProductScreen(),
        },
      ),
    );
  }
}
