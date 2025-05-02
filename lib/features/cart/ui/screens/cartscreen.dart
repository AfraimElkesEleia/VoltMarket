import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/cart/logic/cartprovider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body:
          cart.items.isEmpty
              ? Center(child: Text('Cart is empty'))
              : ListView(
                children:
                    cart.items.values.map((cartItem) {
                      final product = cartItem.product;
                      return ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(product.name),
                        subtitle: Text('Quantity: ${cartItem.quantity}'),
                        trailing: Text(
                          '\$${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                        ),
                      );
                    }).toList(),
              ),
      bottomNavigationBar:
          cart.items.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.borderAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Proceed to checkout logic
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Checkout"),
                      Text('\$${cart.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              )
              : null,

      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(16),
      //   child: Text(
      //     '\$${cart.totalPrice.toStringAsFixed(2)}',
      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }
}
