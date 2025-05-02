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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading || state is CartUpdating) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartError) {
          return Center(child: Text('There is error happened'));
        }
        cartItems = (state as CartLoaded).items;
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
                        onPressed: () {},
                        child: Text(
                          "Proceed to Buy (${context.read<CartCubit>().totalPrice})",
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
