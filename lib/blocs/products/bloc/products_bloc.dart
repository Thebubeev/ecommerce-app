import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_test/blocs/products/bloc/products_event.dart';
import 'package:ecommerce_app_test/blocs/products/bloc/products_state.dart';
import 'package:ecommerce_app_test/repositories/product/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is LoadProduct) {
      yield* _mapLoadProductsToState();
    }
    if (event is UpdateProduct) {
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProduct(products),
          ),
        );
  }

  Stream<ProductState> _mapUpdateProductsToState(UpdateProduct event) async* {
    yield ProductLoaded(products: event.products);
  }
}
