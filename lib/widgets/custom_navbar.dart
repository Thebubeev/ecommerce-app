import 'package:ecommerce_app_test/blocs/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_test/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_app_test/blocs/wishlist/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;
  final GlobalKey<FormState>? globalKey;

  const CustomNavBar(
      {Key? key, required this.screen, this.product, this.globalKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavBar(context);
      case '/catalog':
        return _buildNavBar(context);
      case '/wishlist':
        return _buildNavBar(context);
      case '/confirmation':
        return _buildNavBar(context);
      case '/product':
        return _buildAddToCartNavBar(context, product);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context, globalKey!);

      default:
        _buildNavBar(context);
    }
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      IconButton(
        icon: const Icon(Icons.person, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
      )
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishlistLoaded) {
            return IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                context.read<WishlistBloc>().add(AddWishlist(product));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to your Wishlist!')));
              },
            );
          } else {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddCart(product));
                Navigator.pushNamed(context, '/cart');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
        },
      ),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headline3,
        ),
      )
    ];
  }

  List<Widget> _buildOrderNowNavBar(context, GlobalKey<FormState> _key) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            return ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();
                  context
                      .read<CheckoutBloc>()
                      .add(ConfirmCheckout(checkout: state.checkout));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                      content: Text(
                          'You have sucessfully ordered your items! ${state.checkout.products!.map((product) => product.name)}')));
                  Navigator.pushNamed(context, '/confirmation');
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                'ORDER NOW',
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }
        },
      )
    ];
  }
}
