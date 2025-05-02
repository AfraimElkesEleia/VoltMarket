part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class Loading extends OrderState {}

final class OrdersLoaded extends OrderState {
  final List<Order> orders;

  OrdersLoaded(this.orders);
}

final class OrderListIsEmpty extends OrderState {}

final class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}
