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
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXxZR0_1ISIJx_T4oB5-5OJVSNgSMFLe8eCw&s',
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
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: onSubtract,
                      ),
                      Text(
                        item.quantity.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: onAdd,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: removeItem,
                    icon: Icon(
                      Icons.remove_shopping_cart,
                      size: 20,
                      color: Colors.redAccent,
                    ),
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
