import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_cubit.dart';
import 'package:volt_market/features/cart/ui/screen/cart_screen.dart';
import 'package:volt_market/features/favourites/logic/cubit/favorite_cubit.dart';
import 'package:volt_market/features/favourites/ui/screens/favorite_screen.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';
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
  final LocalAuthentication _auth =
      LocalAuthentication(); // Face ID authentication

  bool _isAuthenticated = false;
  bool _authAttempted = false;
  Future<void> _authenticateWithFaceID() async {
    try {
      bool result = await _auth.authenticate(
        localizedReason: 'Please scan your face to access the app',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticated = result;
        _authAttempted = true;
      });
    } catch (e) {
      print("Face ID error: $e");
      setState(() {
        _authAttempted = true;
      });
    }
  }

  final List<Widget> _screens = [
    const ProductsScreen(),
    BlocProvider(create: (context) => CartCubit(), child: CartScreen()),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticateWithFaceID();
  }

  @override
  Widget build(BuildContext context) {
    if (!_authAttempted) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_isAuthenticated) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Authentication Failed',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticateWithFaceID,
                child: const Text('Retry Face ID'),
              ),
            ],
          ),
        ),
      );
    }
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