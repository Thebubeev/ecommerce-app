part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class StartCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddCart extends CartEvent {
  final Product product;

  const AddCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveCart extends CartEvent {
  final Product product;

  const RemoveCart(this.product);

  @override
  List<Object> get props => [product];
}
