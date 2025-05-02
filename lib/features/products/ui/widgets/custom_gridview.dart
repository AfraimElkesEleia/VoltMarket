import 'package:flutter/material.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/products/models/models.dart';
import 'package:volt_market/features/products/ui/screens/products_screen.dart';

class CustomGridView extends StatelessWidget {
  final List<Category> categories;
  final bool darkmode;

  const CustomGridView({
    super.key,
    required this.darkmode,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ProductsScreen(
                      title: category.name,
                      categoryId: category.id,
                    ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(1, 2),
                ),
              ],
              gradient:
                  darkmode
                      ? ColorsManager.primaryGradient
                      : ColorsManager.lightCardGradient,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    darkmode
                        ? ColorsManager.borderDark
                        : ColorsManager.borderLight,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  category.image, // images goes here
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  textAlign: TextAlign.center,
                  category.name, // texts goes here
                  style: TextStyle(
                    color:
                        darkmode
                            ? ColorsManager.textPrimaryDark
                            : ColorsManager.textPrimaryLight,
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
