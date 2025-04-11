import 'package:flutter/material.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/theme/font_weight_helper.dart';
import 'package:volt_market/core/theme/text_styles.dart';

class PasswordValidationWidget extends StatelessWidget {
  final bool hasUpperChar;
  final bool hasLowerChar;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool hasMinLength;
  const PasswordValidationWidget({
    super.key,
    required this.hasUpperChar,
    required this.hasLowerChar,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.hasMinLength,
  });
  Widget _buildValidationField(String title, bool isMatched) {
    final Color color = isMatched ? Colors.green : Colors.grey[600]!;
    return Row(
      children: [
        Icon(Icons.check_circle, color: color),
        horizontalSpace(10),
        Text(
          title,
          style: TextStyles.font12PoppinsWhiteThin.copyWith(
            color: color,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildValidationField('At least 1 lowercase letter', hasLowerChar),
        verticalSpace(5),
        _buildValidationField('At least 1 uppercase letter', hasUpperChar),
        verticalSpace(5),
        _buildValidationField('At least 1 number letter', hasNumber),
        verticalSpace(5),
        _buildValidationField('At least 1 special char letter', hasSpecialChar),
        verticalSpace(5),
        _buildValidationField(
          'Password must be at least 8 characters',
          hasMinLength,
        ),
      ],
    );
  }
}
