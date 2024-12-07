part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product item;
  final int quantity;

  const AddToCart(this.item, this.quantity);

  @override
  List<Object> get props => [item, quantity];
}

class RemoveFromCart extends CartEvent {
  final int productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateCartQuantity extends CartEvent {
  final int productId;
  final int newQuantity;

  const UpdateCartQuantity(
      {required this.productId, required this.newQuantity});

  @override
  List<Object> get props => [productId, newQuantity];
}

class LoadCart extends CartEvent {}

class SaveCart extends CartEvent {}
