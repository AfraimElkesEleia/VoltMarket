// favorite_cubit.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/networking/cart_service.dart';
import 'package:volt_market/core/networking/favourite_service.dart';
import 'package:volt_market/features/favourites/model/favourite_item.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  late final FavoriteService _favoriteService;
  late final CartService _cartService;
  late final User? currentUser;
  List<FavouriteItem> favorites = [];
  FavoriteCubit() : super(FavoriteInitial()) {
    _favoriteService = FavoriteService();
    _cartService = CartService();
    currentUser = FirebaseAuth.instance.currentUser;
  }
  Future<void> loadFavorites() async {
    emit(Loading());
    try {
      favorites = await _favoriteService
          .getUserFavorites(currentUser!.uid)
          .then((list) {
            return list
                .map((product) => FavouriteItem.fromProduct(product))
                .toList();
          });
      if (!isClosed) {
        emit(FavoriteLoaded(favorites));
      }
    } catch (e) {
      emit(FavoriteError('Failed to load favorites: $e'));
    }
  }

  Future<void> removeFavorite(int productId) async {
    emit(Loading());
    try {
      await _favoriteService.removeFromFavorites(currentUser!.uid, productId);
      if (!isClosed) {
        emit(FavoriteLoaded(favorites));
      }
    } catch (e) {
      emit(FavoriteError('Failed to remove from favorites: $e'));
    }
  }

  Future<void> addToCart(int productId) async {
    emit(Loading());
    try {
      await _cartService.addToCart(
        userId: currentUser!.uid,
        productId: productId,
      );
      emit(CartAdded());
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(CartError('Add to cart failed: $e'));
    }
  }
}
