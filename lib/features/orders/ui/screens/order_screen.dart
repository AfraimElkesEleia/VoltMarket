import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/constants/image_manager.dart';
import 'package:volt_market/features/orders/logic/cubit/order_cubit.dart';
import 'package:volt_market/features/orders/model/order_item.dart';
import 'package:volt_market/features/orders/ui/widgets/order_card.dart';

// ignore: must_be_immutable
class OrdersScreen extends StatelessWidget {
  List<Order> orders = [];

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().fetchUserOrders();
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderError) {
            return Center(
              child: Text('There is Error happend when loading your orders'),
            );
          } else if (state is OrderListIsEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImageManager.noOrdersFound),
                    Text(
                      'No orders yet. Your recent orders will appear here.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
           
          } else {
            orders = (state as OrdersLoaded).orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            );
          }
        },
      ),
    );
  }
}

//const Center(child: Text('No orders yet'))
