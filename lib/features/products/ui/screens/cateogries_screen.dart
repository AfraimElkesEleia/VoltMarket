import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/device_utils.dart';
import 'package:volt_market/features/products/models/models.dart';
import 'package:volt_market/features/products/ui/widgets/custom_appbar.dart';
import 'package:volt_market/features/products/ui/widgets/custom_gridview.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final darkmode = DeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppbar(title: Text("Products"), showBackArrow: false),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: CustomGridView(darkmode: darkmode, categories: categories),
      ),
    );
  }
}
