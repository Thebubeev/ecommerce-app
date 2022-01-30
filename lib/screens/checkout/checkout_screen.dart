import 'package:ecommerce_app_test/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_app_test/widgets/custom_appbar.dart';
import 'package:ecommerce_app_test/widgets/custom_navbar.dart';
import 'package:ecommerce_app_test/widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: CustomNavBar(
        screen: CheckoutScreen.routeName,
        globalKey: _key,
      ),
      body: Form(
        key: _key,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CheckoutLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CUSTOMER INFORMATION',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        _buildTextFormField((value) {
                          context.read<CheckoutBloc>();
                        }, context, 'Email', _emailController),
                        _buildTextFormField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(fullName: value));
                        }, context, 'Full Name', _nameController),
                        const SizedBox(height: 20),
                        Text(
                          'DELIVERY INFORMATION',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        _buildTextFormField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(address: value));
                        }, context, 'Address', _addressController),
                        _buildTextFormField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(city: value));
                        }, context, 'City', _cityController),
                        _buildTextFormField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(country: value));
                        }, context, 'Country', _countryController),
                        _buildTextFormField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(zipCode: value));
                        }, context, 'ZIP Code', _zipController),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Text(
                                  'SELECT A PAYMENT METHOD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'ORDER SUMMARY',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const OrderSummary()
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong...'),
                  );
                }
              },
            )),
      ),
    );
  }

  Padding _buildTextFormField(Function(String)? onChanged, BuildContext context,
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextFormField(
              onSaved: (val) {
                setState(() {
                  controller.text = val!;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter your credentials, please';
                } else {
                  return null;
                }
              },
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
