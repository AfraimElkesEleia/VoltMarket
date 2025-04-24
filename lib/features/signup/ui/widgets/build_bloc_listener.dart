import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/signup/logic/cubit/signup_cubit.dart';

class BuildBlocListener extends StatelessWidget {
  const BuildBlocListener({super.key});
  void showProgressbar(BuildContext context) {
    final AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (_) => alertDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (current, prev) => current != prev,
      listener: (context, state) {
        if (state is Loading) {
          showProgressbar(context);
        } else if (state is SignupFailed) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMsg),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        } else if (state is SignupSuccess) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Check Your Email ✔️'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
          bool isLastScreen = !Navigator.canPop(context);
          if (isLastScreen) {
            context.pushReplacementNamed(MyRoutes.loginScreen);
          } else {
            context.pop();
          }
        }
      },
      child: Container(),
    );
  }
}
