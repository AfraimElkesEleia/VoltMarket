import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/theme/text_styles.dart';

class PageViewScreenWidget extends StatelessWidget {
  final String img, title, description;
  const PageViewScreenWidget({
    super.key,
    required this.img,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img),
          Text(
            title,
            style: TextStyles.font20PoppinsWhiteBold.copyWith(height: 1.2),
            textAlign: TextAlign.center,
          ),
          verticalSpace(10),
          Text(
            description,
            style: TextStyles.font12PoppinsWhiteThin,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
