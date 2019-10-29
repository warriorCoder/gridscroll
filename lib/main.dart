import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_autoscroll/bloc/bloc.dart';
import 'package:grid_autoscroll/products.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Scroll Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AutoScrollBloc>(
        builder: (BuildContext context) =>
            AutoScrollBloc()..add(LoadProducts()),
        child: MyHomePage(title: 'Grid Auto Scroll'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AutoScrollBloc _bloc;
  var _offset = 0.0;
  var _scroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AutoScrollBloc>(context);
  }

  Future<void> _refresh() async {
    _bloc.add(LoadProducts());
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<AutoScrollBloc, AutoScrollState>(
        listener: (context, state) {
          if (state is ProductsLoaded && _offset > 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scroller.animateTo(
                _offset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            });
          }
        },
        child: BlocBuilder<AutoScrollBloc, AutoScrollState>(
          builder: (context, state) {
            if (state is ProductsLoading)
              return Center(child: CircularProgressIndicator());
            if (state is ProductsLoaded) {
              return GridView.count(
                controller: _scroller,
                crossAxisCount: 2,
                children: state.products.map<Widget>(
                  (Product product) {
                    return Dismissible(
                      key: Key(product.name),
                      onDismissed: (direction) {
                        _bloc.add(DeleteProduct(product));
                        setState(() {
                          _offset = _scroller.offset;
                        });
                      },
                      child: Card(
                        child: Center(
                          child: Text(
                            product.name,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            }
            return RefreshIndicator(
              onRefresh: _refresh,
              child: Center(
                child: Text("Didn't load products"),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
