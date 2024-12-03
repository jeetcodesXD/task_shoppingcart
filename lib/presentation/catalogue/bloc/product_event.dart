part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int page;
  final int limit;

  const FetchProducts({required this.page, required this.limit});
}

final class LoadMoreProducts extends ProductEvent {
  final int page;
  final int limit;

  const LoadMoreProducts({required this.page, required this.limit});
}

final class FetchSearchItems extends ProductEvent {
  final String query;
  const FetchSearchItems(this.query);
}
