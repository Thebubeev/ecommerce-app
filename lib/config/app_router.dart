import 'package:ecommerce_app_test/models/category_model.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:ecommerce_app_test/screens/cart/cart_screen.dart';
import 'package:ecommerce_app_test/screens/catalog/catalog_screen.dart';
import 'package:ecommerce_app_test/screens/checkout/checkout_screen.dart';
import 'package:ecommerce_app_test/screens/confirmation/confirmation_screen.dart';
import 'package:ecommerce_app_test/screens/home/home_screen.dart';
import 'package:ecommerce_app_test/screens/product/product_screen.dart';
import 'package:ecommerce_app_test/screens/splash/splash_screen.dart';
import 'package:ecommerce_app_test/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      // ignore: no_duplicate_case_values
      case HomeScreen.routeName:
        return HomeScreen.route();

      case ConfirmationScreen.routeName:
        return ConfirmationScreen.route();

      case CartScreen.routeName:
        return CartScreen.route();

      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);

      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);

      case WishlistScreen.routeName:
        return WishlistScreen.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case CheckoutScreen.routeName:
        return CheckoutScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
            ));
  }
}
