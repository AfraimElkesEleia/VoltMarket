class Order {
  final String id;
  final DateTime date;
  final List<OrderItem> items;
  final double total;
  final OrderStatus status;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });

  factory Order.fromMap(
    Map<String, dynamic> map,
    List<Map<String, dynamic>> itemMaps,
  ) {
    return Order(
      id: map['id'].toString(),
      date: DateTime.parse(map['order_date']),
      total: (map['total_amount'] as num).toDouble(),
      status: _parseStatus(map['status']),
      items: itemMaps.map((itemMap) => OrderItem.fromMap(itemMap)).toList(),
    );
  }

  static OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.processing; // fallback
    }
  }
}

class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  double get subtotal => price * quantity;

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['product_id'].toString(),
      name: map['product_name'] ?? 'Unnamed Product',
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'],
      imageUrl: map['image_url'],
    );
  }
}

enum OrderStatus { processing, shipped, delivered, cancelled }
