import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;

  Product({this.id, this.name, this.price});

  @override
  List<Object> get props => [name, price];
}
