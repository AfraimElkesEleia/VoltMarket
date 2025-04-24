import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/constants/image_manager.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';

class PicImageWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const PicImageWidget({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    context.read<SignupCubit>().imgFile == null
                        ? AssetImage(ImageManager.noProfilePic)
                        : FileImage(context.read<SignupCubit>().imgFile!),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
