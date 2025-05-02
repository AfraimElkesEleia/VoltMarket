import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/home/ui/screens/home.dart';
import 'package:volt_market/features/products/ui/screens/cateogries_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());
  final LocalAuthentication _auth =
      LocalAuthentication(); // Face ID authentication

  bool _isAuthenticated = false;
  bool _authAttempted = false;

  @override
  void initState() {
    super.initState();
    _authenticateWithFaceID();
  }

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

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    // loading screen until verification
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

    // If authenticated, show the real navigation menu
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: darkmode ? Colors.black87 : Colors.white,
          indicatorColor:
              darkmode
                  ? ColorsManager.buttonColor
                  : ColorsManager.darkBlueViolet,
          //navigation buttons
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Products"),
            NavigationDestination(
              icon: Icon(Iconsax.shopping_cart),
              label: "Cart",
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  // TODO: Add cart fav profile screens and their icons
  final screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    Container(), // Cart placeholder
    Container(color: Colors.amber), // Profile placeholder
  ];
}
