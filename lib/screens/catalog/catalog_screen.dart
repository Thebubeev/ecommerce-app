
import 'package:ecommerce_app_test/models/category_model.dart';
import 'package:ecommerce_app_test/models/models.dart';
import 'package:ecommerce_app_test/widgets/custom_appbar.dart';
import 'package:ecommerce_app_test/widgets/custom_navbar.dart';
import 'package:ecommerce_app_test/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  final Category category;

  const CatalogScreen({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName,),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.15),
        itemCount: categoryProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
              child: ProductCard(
            product: categoryProducts[index],
            widthFactor: 2.2,
          ));
        },
      ),
    );
  }
}
