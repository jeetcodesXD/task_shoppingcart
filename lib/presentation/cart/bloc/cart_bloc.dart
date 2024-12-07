import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/dataprovider/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<SaveCart>(_onSaveCart);
    on<LoadCart>(_onLoadCart);
    add(LoadCart());
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.items);

    final existingItemIndex =
        updatedItems.indexWhere((item) => item.id == event.item.id);

    if (existingItemIndex >= 0) {
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity! + event.quantity,
      );
    } else {
      updatedItems.add(event.item.copyWith(quantity: event.quantity));
    }

    final totalPrice = _calculateTotalPrice(updatedItems);

    emit(state.copyWith(items: updatedItems, totalPrice: totalPrice));
    add(SaveCart());
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final updatedItems =
        state.items.where((item) => item.id != event.productId).toList();

    final totalPrice = _calculateTotalPrice(updatedItems);

    emit(state.copyWith(items: updatedItems, totalPrice: totalPrice));
    add(SaveCart());
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<CartState> emit) {
    final updatedItems = List<Product>.from(state.items);

    final existingItemIndex =
        updatedItems.indexWhere((item) => item.id == event.productId);

    if (existingItemIndex >= 0) {
      final existingItem = updatedItems[existingItemIndex];

      if (event.newQuantity > 0) {
        updatedItems[existingItemIndex] =
            existingItem.copyWith(quantity: event.newQuantity);
      } else {
        updatedItems.removeAt(existingItemIndex);
      }
    }

    final totalPrice = _calculateTotalPrice(updatedItems);

    emit(state.copyWith(items: updatedItems, totalPrice: totalPrice));
    add(SaveCart());
  }

  Future<void> _onSaveCart(SaveCart event, Emitter<CartState> emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cartData = state.items.map((item) => item.toJson()).toList();
    await sharedPreferences.setString('cart', jsonEncode(cartData));
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cartJson = sharedPreferences.getString('cart');
    if (cartJson != null) {
      final cartData = jsonDecode(cartJson) as List<dynamic>;
      final items = cartData.map((item) => Product.fromJson(item)).toList();
      final totalPrice = _calculateTotalPrice(items);
      emit(state.copyWith(items: items, totalPrice: totalPrice));
    }
  }

  double _calculateTotalPrice(List<Product> items) {
    return items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity!),
    );
  }
}
