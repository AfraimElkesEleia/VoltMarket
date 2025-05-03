import 'package:flutter/material.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {}

class CartRemoving extends CartState {}

class CartUpdating extends CartState {}

class CartError extends CartState {
  final String message;
  final List<CartItem>? items;

  const CartError({required this.message, this.items});
}

class OrderIsDone extends CartState {}

class CartIsEmpty extends CartState {}
