// favorite_state.dart
import 'package:flutter/foundation.dart';
import 'package:volt_market/features/favourites/model/favourite_item.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class Loading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<FavouriteItem> favorites;

  FavoriteLoaded(this.favorites);
}
final class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}

final class CartAdded extends FavoriteState {
}

final class CartError extends FavoriteState {
  final String message;

  CartError(this.message);
}
