import 'package:ecommerce_app_test/blocs/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const CartProductCard(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text('\$${product.price}',
                    style: Theme.of(context).textTheme.headline5),
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(RemoveCart(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                content: Text('Deleted from your Cart!')));
                        print(
                            'Product ${product.name} was deleted from your Cart');
                      },
                      icon: const Icon(Icons.remove_circle)),
                  Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(AddCart(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.black,
                                duration: Duration(seconds: 2),
                                content: Text('Added to your Cart!')));
                        print('Product ${product.name} was added to your Cart');
                      },
                      icon: const Icon(Icons.add_circle))
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
