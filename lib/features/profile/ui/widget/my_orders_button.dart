import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';

class MyOrdersButton extends StatelessWidget {
  const MyOrdersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'View My Orders',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          context.pushNamed(MyRoutes.myOrdersScreen); // Ensure route is defined
        },
      ),
    );
  }
}
