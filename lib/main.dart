import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/dataprovider/products/remote_service.dart';
import 'package:shopping_cart/presentation/cart/bloc/cart_bloc.dart';
import 'package:shopping_cart/presentation/catalogue/bloc/product_bloc.dart';
import 'package:shopping_cart/presentation/catalogue/catalogue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productDataSource = ProductDataSource();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(productDataSource: productDataSource)
            ..add(const FetchProducts(page: 1, limit: 20)),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const CatalogueScreen(),
      ),
    );
  }
}
