import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:volt_market/core/networking/order_service.dart';
import 'package:volt_market/features/orders/model/order_item.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  late final OrderService _orderService;

  OrderCubit() : super(OrderInitial()) {
    _orderService = OrderService();
  }

  Future<void> fetchUserOrders() async {
    try {
      emit(Loading());

      final rawOrders = await _orderService.getUserOrders();
      if (rawOrders.isEmpty) {
        emit(OrderListIsEmpty());
        return;
      }
      debugPrint("orders : ${rawOrders.toString()}");
      final orders =
          rawOrders.map((orderMap) {
            final orderItemsRaw =
                (orderMap['order_items'] as List<dynamic>)
                    .cast<Map<String, dynamic>>();

            final items =
                orderItemsRaw.map((itemMap) {
                  final product = itemMap['products'];
                  // final variant = itemMap['product_variants'];

                  return OrderItem(
                    productId: itemMap['product_id'].toString(),
                    name: product['title'] ?? 'Unnamed Product',
                    price: product['price'] ?? 0.0.toDouble(),
                    quantity: itemMap['quantity'],
                    imageUrl: product['img_url'],
                  );
                }).toList();

            return Order.fromMap(
              orderMap,
              items
                  .map(
                    (e) => {
                      'product_id': e.productId,
                      'product_name': e.name,
                      'price': e.price,
                      'quantity': e.quantity,
                      'image_url': e.imageUrl,
                    },
                  )
                  .toList(),
            );
          }).toList();

      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
