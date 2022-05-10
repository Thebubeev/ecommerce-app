part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final String? id;
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final List<Product>? images;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;
  final bool? isAccepted;
  final bool? isDelivered;
  final bool? isCancelled;
  final DateTime? orderedAt;
  final Checkout checkout;

  CheckoutLoaded(
      { this.id,
      this.fullName,
      this.email,
      this.address,
      this.city,
      this.country,
      this.zipCode,
      this.products,
      this.images,
      this.subtotal,
      this.deliveryFee,
      this.total,
      this.isAccepted,
      this.isDelivered,
      this.isCancelled,
      this.orderedAt})
      : checkout = Checkout(
          id: id,
          fullName: fullName,
          email: email,
          address: address,
          city: city,
          country: country,
          zipCode: zipCode,
          products: products,
          images: images,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          total: total,
          isAccepted: false,
          isCancelled: false,
          isDelivered: false,
          orderedAt: DateTime.now(),
        );

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        products,
        images,
        subtotal,
        deliveryFee,
        total,
        isAccepted,
        isDelivered,
        isCancelled,
        orderedAt
      ];
}
