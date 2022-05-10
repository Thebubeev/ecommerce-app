import 'package:ecommerce_app_test/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_app_test/config/theme.dart';
import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:ecommerce_app_test/widgets/custom_appbar.dart';
import 'package:ecommerce_app_test/widgets/custom_navbar.dart';
import 'package:ecommerce_app_test/widgets/order_summary.dart';
import 'package:ecommerce_app_test/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationScreen extends StatelessWidget {
  static const String routeName = '/confirmation';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const ConfirmationScreen());
  }

  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Confirmation',
      ),
      bottomNavigationBar: const CustomNavBar(
        screen: routeName,
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Your order is complete!',
                        style:
                            Theme.of(context).textTheme.headline2!.copyWith(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        'Hi, ${state.fullName}, your order was successful!\nThanks for purschasing from our store!',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'ORDER CODE: #J2J2R3R-R3RT3',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const OrderSummary(),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'ORDER DETAILS',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const Divider(
                      thickness: 2.0,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OrderSummaryCard(
                              product: state.products![index]
                                  .productQuantity(state.products)
                                  .keys
                                  .elementAt(index),
                              quantity: state.products![index]
                                  .productQuantity(state.products)
                                  .values
                                  .elementAt(index));
                        },
                        itemCount: state.products![state.products!.length - 1]
                            .productQuantity(state.products)
                            .keys
                            .length)
                  ],
                ),
              ),
            );
          }

          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const OrderSummaryCard({
    required this.product,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            height: 90,
            width: 100,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Quantity: $quantity',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Text("\$${product.price}",
                style: Theme.of(context).textTheme.headline4),
          ),
        ],
      ),
    );
  }
}
