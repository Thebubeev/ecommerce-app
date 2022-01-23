import 'package:ecommerce_app_test/bloc_observer.dart';
import 'package:ecommerce_app_test/blocs/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app_test/blocs/category/bloc/category_bloc.dart';
import 'package:ecommerce_app_test/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_app_test/blocs/products/bloc/products_bloc.dart';
import 'package:ecommerce_app_test/blocs/products/bloc/products_event.dart';
import 'package:ecommerce_app_test/blocs/wishlist/bloc/wishlist_bloc.dart';
import 'package:ecommerce_app_test/config/app_router.dart';
import 'package:ecommerce_app_test/config/theme.dart';
import 'package:ecommerce_app_test/repositories/category/category_repository.dart';
import 'package:ecommerce_app_test/repositories/checkout/checkout_repository.dart';
import 'package:ecommerce_app_test/repositories/product/product_repository.dart';
import 'package:ecommerce_app_test/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => WishlistBloc()..add(WishlistStarted())),
        BlocProvider(create: (context) => CartBloc()..add(CartStarted())),
        BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository: CategoryRepository())
                  ..add(LoadCategories())),
        BlocProvider(
            create: (context) =>
                ProductBloc(productRepository: ProductRepository())
                  ..add(LoadProduct())),
        BlocProvider(
            create: (context) => CheckoutBloc(
                cartBloc: context.read<CartBloc>(),
                checkoutRepository: CheckoutRepository())),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: HomeScreen(),
      ),
    );
  }
}
