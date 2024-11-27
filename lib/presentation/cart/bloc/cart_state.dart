part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<Product> items;
  final double totalPrice;

  const CartState({
    this.items = const [],
    this.totalPrice = 0.0,
  });

  CartState copyWith({
    List<Product>? items,
    double? totalPrice,
  }) {
    return CartState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [items, totalPrice];
}
