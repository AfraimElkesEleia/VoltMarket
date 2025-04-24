import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_market/core/constants/deopdown_cities.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/widgets/text_app_widget.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';

class ZipAndCityFields extends StatefulWidget {
  const ZipAndCityFields({super.key});

  @override
  State<ZipAndCityFields> createState() => _ZipAndCityFieldsState();
}

class _ZipAndCityFieldsState extends State<ZipAndCityFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextAppWidget(
            textEditingController:
                context.read<SignupCubit>().zipTextController,
            text: 'Zip Code',
            prefixIcon: Icons.message,
            keyboardType: TextInputType.number,
            validator: (zip) {
              if (zip == null || zip.isEmpty) {
                return '*required';
              }
              return null;
            },
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Container(
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: governorateItems,
                  onChanged: (value) {
                    context.read<SignupCubit>().dropdownValue =
                        value.toString();
                    setState(() {});
                  },
                  value: context.read<SignupCubit>().dropdownValue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
