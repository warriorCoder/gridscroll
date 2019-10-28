import 'package:equatable/equatable.dart';
import 'package:grid_autoscroll/products.dart';

abstract class AutoScrollEvent extends Equatable {
  const AutoScrollEvent();
}

class DeleteProduct extends AutoScrollEvent {
  final Product product;
  DeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}

class LoadProducts extends AutoScrollEvent {
  
  @override
  List<Object> get props => [];
}
