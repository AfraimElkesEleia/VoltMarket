import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/app_regex.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/widgets/text_app_widget.dart';
import 'package:volt_market/features/login/logic/cubit/login_cubit.dart';

class EmailAndPasswordFields extends StatefulWidget {
  const EmailAndPasswordFields({super.key});

  @override
  State<EmailAndPasswordFields> createState() => _EmailAndPasswordFieldsState();
}

class _EmailAndPasswordFieldsState extends State<EmailAndPasswordFields> {
  bool isObsecure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: context.read<LoginCubit>().formKey,
          child: Column(
            children: [
              TextAppWidget(
                textEditingController:
                    context.read<LoginCubit>().emailTextEditingControler,
                text: 'Email',
                prefixIcon: Icons.email,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Email is required';
                  } else if (!AppRegex.checkEmailText(email)) {
                    return 'Email is not valid';
                  }
                  return null;
                },
              ),
              verticalSpace(20),
              TextAppWidget(
                textEditingController:
                    context.read<LoginCubit>().passwordTextEditingController,
                text: 'Password',
                prefixIcon: Icons.password,
                isObsecure: isObsecure,
                suffixIcon: IconButton(
                  onPressed: () {
                    isObsecure = !isObsecure;
                    setState(() {});
                  },
                  icon:
                      isObsecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(MyRoutes.forgetPasswordScreen),
              child: Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
