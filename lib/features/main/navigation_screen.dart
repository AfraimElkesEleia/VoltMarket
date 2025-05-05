import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_cubit.dart';
import 'package:volt_market/features/cart/ui/screen/cart_screen.dart';
import 'package:volt_market/features/favourites/logic/cubit/favorite_cubit.dart';
import 'package:volt_market/features/favourites/ui/screens/favorite_screen.dart';
import 'package:volt_market/features/products/ui/screens/products_screen.dart';
import 'package:volt_market/features/profile/logic/cubit/profile_cubit.dart';
import 'package:volt_market/features/profile/ui/screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ProductsScreen(),
    BlocProvider(create: (context) => CartCubit(), child: const CartScreen()),
    BlocProvider(
      create: (context) => FavoriteCubit(),
      child: const FavouriteScreen(),
    ),
    BlocProvider(
      create: (context) => ProfileCubit(),
      child: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
