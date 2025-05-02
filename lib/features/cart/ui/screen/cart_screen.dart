import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_cubit.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_state.dart';
import 'package:volt_market/features/cart/ui/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];
  bool isUpdating = false;
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      buildWhen:
          (previous, current) =>
              current is CartError ||
              current is CartLoaded ||
              current is CartUpdating,
      listener: (context, state) {
        if (state is CartRemoving || state is CartUpdating) {
          isUpdating = true;
        } else if (state is OrderIsDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your order has been placed successfully! 🎉"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CartIsEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Oops! You need to add something to your cart first",
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is CartLoaded || state is OrderIsDone) {
          isUpdating = false;
        }
      },
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartError) {
          return Center(child: Text('There is error happened'));
        }
        if (state is CartLoaded) {
          cartItems = state.items;
        }
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                //ListView.Builder
                //====================================================
                //====================================================
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          item: cartItems[index],
                          onAdd: () {
                            setState(() {
                              cartItems[index].quantity++;
                              context.read<CartCubit>().updateQuantity(
                                cartItems[index].productId,
                                cartItems[index].quantity,
                              );
                            });
                          },
                          onSubtract: () {
                            setState(() {
                              if (cartItems[index].quantity > 1) {
                                cartItems[index].quantity--;
                                context.read<CartCubit>().updateQuantity(
                                  cartItems[index].productId,
                                  cartItems[index].quantity,
                                );
                              } else {
                                context.read<CartCubit>().removeFromCart(
                                  cartItems[index].productId,
                                );
                                cartItems.removeAt(index);
                              }
                            });
                          },
                          removeItem: () {
                            setState(() {
                              context.read<CartCubit>().removeFromCart(
                                cartItems[index].productId,
                              );
                              cartItems.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

                //Proceed to Buy Button
                //=========================================================
                //=========================================================
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                            255,
                            32,
                            29,
                            56,
                          ), // Button background color
                          foregroundColor: Colors.white, // Text color
                          minimumSize: Size(
                            150,
                            70,
                          ), // Makes it square (equal width and height)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ), // Slightly rounded corners
                          ),
                        ),
                        onPressed: () {
                          context.read<CartCubit>().createOrderFromCart();
                        },
                        child:
                            isUpdating
                                ? CircularProgressIndicator()
                                : Text(
                                  "Proceed to Buy (\$${context.read<CartCubit>().totalPrice})",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
