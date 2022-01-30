import 'package:ecommerce_app_test/blocs/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_test/blocs/wishlist/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;

  const ProductCard(
      {Key? key,
      required this.product,
      this.widthFactor = 2.25,
      this.isWishlist = false,
      this.leftPosition = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: product);
        },
        child: Stack(
          children: [
            SizedBox(
              width: widthValue,
              height: 150,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                child: Container(
              width: widthValue - 10,
              height: 80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
            )),
            Positioned(
              top: 65,
              left: leftPosition + 5,
              child: Container(
                width: widthValue - 15 - leftPosition,
                height: 70,
                decoration: const BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is CartLoaded) {
                            return Expanded(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(AddCart(product));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.black,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                  'Added to your Cart!')));
                                      print(
                                          'Product ${product.name} was added to Cart');
                                },
                              ),
                            );
                          }
                          return const Center(
                            child: Text('Something went wrong...'),
                          );
                        },
                      ),
                      isWishlist
                          ? BlocBuilder<WishlistBloc, WishlistState>(
                              builder: (context, state) {
                                return Expanded(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<WishlistBloc>()
                                          .add(RemoveWishlist(product));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                  'Deleted from your Wishlist!')));
                                      print(
                                          'Product ${product.name} was deleted from Wishlist');
                                    },
                                  ),
                                );
                              },
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
