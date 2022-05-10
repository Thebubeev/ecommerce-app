import 'package:ecommerce_app_test/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
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

  const Checkout(
      {required this.images, required this.id,
      required this.fullName,
      required this.email,
      required this.address,
      required this.city,
      required this.country,
      required this.zipCode,
      required this.products,
      required this.subtotal,
      required this.deliveryFee,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.isCancelled,
      required this.orderedAt});

  @override
  List<Object?> get props => [
    images,
        id,
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        products,
        subtotal,
        deliveryFee,
        total,
        isAccepted,
        isDelivered,
        isCancelled,
        orderedAt
      ];

  Map<String, Object> toDocument() { // toJson
    Map customerAddress = Map();
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;

    return {
      'id': id!,
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'customerEmail': email!,
      'products': products!.map((product) => product.name).toList(),
      'images' : products!.map((product) => product.imageUrl).toList(),
      'subtotal': subtotal!,
      'deliveryFee': deliveryFee!,
      'total': total!,
      'isAccepted': isAccepted!,
      'isDelivered': isDelivered!,
      'isCancelled': isCancelled!,
      'orderedAt': orderedAt!,
    };
  }
}
