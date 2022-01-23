import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {}

class UpdateProduct extends ProductEvent {
  final List<Product> products;

  const UpdateProduct(this.products);

  @override
  List<Object> get props => [products];
}
