import 'package:equatable/equatable.dart';
import 'package:grid_autoscroll/products.dart';

abstract class AutoScrollState extends Equatable {
  const AutoScrollState();
}

class InitialAutoScrollState extends AutoScrollState {
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends AutoScrollState {
  final List<Product> products;
  ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsNotLoaded extends AutoScrollState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends AutoScrollState {
  @override
  List<Object> get props => [];
}
