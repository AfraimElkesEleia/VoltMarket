import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/features/favourites/logic/cubit/favorite_cubit.dart';
import 'package:volt_market/features/favourites/logic/cubit/favorite_state.dart';
import 'package:volt_market/features/favourites/model/favourite_item.dart';
import 'package:volt_market/features/favourites/ui/widgets/favorite_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});
  @override
  State<FavouriteScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouriteScreen> {
  List<FavouriteItem> favouriteItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoriteCubit>().loadFavorites();
  }

  void removeFromFavourites(int index) {
    setState(() {
      context.read<FavoriteCubit>().removeFavorite(
        favouriteItems[index].productId,
      );
      favouriteItems.removeAt(index);
    });
  }

  void addToCart(int index) {
    setState(() {});
    context.read<FavoriteCubit>().addToCart(favouriteItems[index].productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'), centerTitle: true),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        buildWhen:
            (previous, current) =>
                current is Loading ||
                current is FavoriteLoaded ||
                current is FavoriteError ||
                current is CartError,
        listener: (context, state) {
          if (state is CartAdded) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Added to cart")));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteError) {
            return Center(
              child: Text('Error in adding favorite ${state.message}'),
            );
          } else if (state is CartError) {
            return Center(child: Text('Error in adding Cart ${state.message}'));
          }

          favouriteItems = (state as FavoriteLoaded).favorites;
          return ListView.builder(
            itemCount: favouriteItems.length,
            itemBuilder: (context, index) {
              final item = favouriteItems[index];
              return FavoriteWidget(
                item: item,
                removeFromFavourites: () {
                  removeFromFavourites(index);
                },
                addToCart: () {
                  addToCart(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
