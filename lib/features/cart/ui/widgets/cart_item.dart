import 'package:flutter/material.dart';
import 'package:volt_market/features/cart/model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onSubtract;
  final VoidCallback removeItem;

  const CartItemWidget({
    required this.item,
    required this.onAdd,
    required this.onSubtract,
    required this.removeItem,
    super.key,
  });

  //Card Shape Customization
  //============================
  //============================
  //============================
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 32, 29, 56),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Color.fromARGB(255, 32, 29, 56),
          child: Row(
            children: [
              // Image Settings Here
              //==================================================
              //==================================================
              Container(
                width: 80,
                height: 80,
                child: Image.network(
                  item.product.imgUrl ??
                      'data:image/jpeg;base64,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',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.phone_iphone,
                      size: 40,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              SizedBox(width: 10),

              // Product Name and Price Here
              // ======================================================
              //==========================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item.product.price.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 61, 216),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              //Quantity Controls Here
              //==============================================
              //===============================================
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: onSubtract,
                      ),
                      Text(
                        item.quantity.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: onAdd),
                    ],
                  ),
                  IconButton(
                    onPressed: removeItem,
                    icon: Icon(Icons.remove_shopping_cart, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
