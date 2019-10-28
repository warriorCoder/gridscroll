import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grid_autoscroll/products.dart';
import './bloc.dart';

class AutoScrollBloc extends Bloc<AutoScrollEvent, AutoScrollState> {
  var _products = [
    Product(id: 1, name: "Apple", price: 3),
    Product(id: 2, name: "Apricot", price: 2),
    Product(id: 3, name: "Avocado", price: 1),
    Product(id: 4, name: "Acai", price: 3),
    Product(id: 5, name: "Banana", price: 3),
    Product(id: 6, name: "Blueberry", price: 3),
    Product(id: 7, name: "Blackberry", price: 3),
    Product(id: 8, name: "Bilberry", price: 3),
    Product(id: 9, name: "Grapefruit", price: 3),
    Product(id: 10, name: "Honeydew", price: 3),
    Product(id: 11, name: "Honeysuckle", price: 3),
    Product(id: 12, name: "Jackfruit", price: 3),
    Product(id: 13, name: "Kiwi", price: 3),
    Product(id: 14, name: "Lemon", price: 3),
    Product(id: 15, name: "Lingonberry", price: 3),
    Product(id: 16, name: "Loquat", price: 3),
    Product(id: 17, name: "Macadamia", price: 3),
    Product(id: 18, name: "Neem", price: 3),
    Product(id: 19, name: "Nectarine", price: 3),
    Product(id: 20, name: "Olive", price: 3),
    Product(id: 21, name: "Orange", price: 3),
    Product(id: 22, name: "Peach", price: 3),
    Product(id: 23, name: "Peanut", price: 3),
    Product(id: 24, name: "Pecan", price: 3),
    Product(id: 25, name: "Persimmon", price: 3),
    Product(id: 26, name: "Rubarb", price: 3),
    Product(id: 27, name: "Tomato", price: 3),
    Product(id: 28, name: "Tangerine", price: 3),
    Product(id: 29, name: "Watermelon", price: 3),
    Product(id: 30, name: "Walnut", price: 3),
    Product(id: 31, name: "Yuzu", price: 3),
  ];
  @override
  AutoScrollState get initialState => InitialAutoScrollState();

  @override
  Stream<AutoScrollState> mapEventToState(
    AutoScrollEvent event,
  ) async* {
    if (event is LoadProducts)
      yield ProductsLoaded(_products);
    else if (event is DeleteProduct) yield* _mapDeleteProductToState(event);
  }

  Stream<AutoScrollState> _mapDeleteProductToState(DeleteProduct event) async* {
    final _state = state;
    yield (ProductsLoading());
    if (_state is ProductsLoaded) {
      final List<Product> products =
          _state.products.where((p) => p.name != event.product.name).toList();
      await Future.delayed(Duration(seconds: 5));
      yield ProductsLoaded(products);
    } else
      yield ProductsNotLoaded();
  }
}
