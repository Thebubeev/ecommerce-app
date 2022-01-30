import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({required this.name, required this.imageUrl});

  static Category fromSnaphot(DocumentSnapshot snapshot) {
    Category category =
        Category(name: snapshot['name'], imageUrl: snapshot['imageUrl']);
    return category;
  }

  @override
  List<Object?> get props => [name, imageUrl];
}
