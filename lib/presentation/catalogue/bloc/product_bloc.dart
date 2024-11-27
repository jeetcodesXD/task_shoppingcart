import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/core/helper/data_state.dart';
import 'package:shopping_cart/dataprovider/models/product.dart';
import 'package:shopping_cart/dataprovider/products/remote_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDataSource _productDataSource;
  int currentPage = 1;
  final int limit = 10;
  ProductBloc({required ProductDataSource productDataSource})
      : _productDataSource = productDataSource,
        super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());

      final dataState =
          await _productDataSource.getProducts(event.page, event.limit);

      if (dataState is DataSuccess) {
        emit(ProductLoaded(products: dataState.data!));
      } else {
        emit(ProductError(message: dataState.error.toString()));
      }
    });

    on<LoadMoreProducts>((event, emit) async {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final currentProducts = currentState.products;

        final dataState =
            await _productDataSource.getProducts(event.page, event.limit);

        if (dataState is DataSuccess) {
          final newProducts = dataState.data!;
          emit(ProductLoaded(products: [...currentProducts, ...newProducts]));
        } else {
          emit(ProductError(message: dataState.error.toString()));
        }
      }
    });
  }
}
