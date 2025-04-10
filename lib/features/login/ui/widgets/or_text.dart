import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';

class OrText extends StatelessWidget {
  const OrText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 2, color: Colors.grey[300])),
        horizontalSpace(8),
        Text('OR'),
        horizontalSpace(8),
        Expanded(child: Container(height: 2, color: Colors.grey[300])),
      ],
    );
  }
}
