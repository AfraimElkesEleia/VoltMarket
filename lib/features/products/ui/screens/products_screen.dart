import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/products/models/models.dart';
import 'package:volt_market/features/products/ui/screens/itemdetails.dart';
import 'package:volt_market/features/products/ui/widgets/custom_appbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.title,
    required this.categoryId,
  });
  final String? title;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    final category = categories.firstWhere((cat) => cat.id == categoryId);
    final categoryProducts =
        products.where((p) => p.categoryId == categoryId).toList();

    return Scaffold(
      appBar: CustomAppbar(title: Text(category.name), showBackArrow: true),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: categoryProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Itemdetails(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:
                            darkmode
                                ? ColorsManager.primaryGradient
                                : ColorsManager.lightCardGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 6,

                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      darkmode
                                          ? ColorsManager.borderDark
                                              .withOpacity(0.2)
                                          : ColorsManager.borderLight
                                              .withOpacity(0.2),
                                  width: 1.5,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          darkmode
                                              ? Colors.white
                                              : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // TODO: handle favorite logic here
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                          color:
                                              darkmode
                                                  ? Colors.white
                                                  : Colors.black87,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // TODO: add shop cart logic
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
