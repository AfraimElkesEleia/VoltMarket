import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_cubit.dart';
import 'package:volt_market/features/cart/logic/cubit/cart_state.dart';
import 'package:volt_market/features/cart/ui/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  List<CartItem> cartItems = [];
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    context.read<CartCubit>().loadCart();
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
          AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: true,
            title: 'Succes',
            desc: 'Your order has been placed successfully! 🎉',
            btnOkOnPress: () {
              debugPrint('OnClcik');
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
        } else if (state is CartIsEmpty) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: 'Error',
            desc: 'Oops! You need to add something to your cart first',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
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
        cartItems = context.read<CartCubit>().items;
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                //ListView.Builder
                //====================================================
                //====================================================
                Expanded(
                  child: Container(
                    color: darkmode ? Color(0xFF121212) : Colors.white,
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          item: cartItems[index],
                          onAdd: () {
                            cartItems[index].quantity++;
                            context.read<CartCubit>().updateQuantity(
                              cartItems[index].productId,
                              cartItems[index].quantity,
                            );
                          },
                          onSubtract: () {
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
                          },
                          removeItem: () {
                            context.read<CartCubit>().removeFromCart(
                              cartItems[index].productId,
                            );
                            cartItems.removeAt(index);
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
                  color: darkmode ? Color(0xFF121212) : Colors.white,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              darkmode
                                  ? Color(0xFF4E47A1)
                                  : Color.fromARGB(
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
