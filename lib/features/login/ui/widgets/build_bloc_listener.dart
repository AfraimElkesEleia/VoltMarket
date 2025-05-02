import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/login/logic/cubit/login_cubit.dart';

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

  void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (current, prev) => current != prev,
      listener: (context, state) {
        if (state is Loading) {
          showProgressbar(context);
          debugPrint('LOGIN loading');
        } else if (state is SigninFailed) {
          debugPrint('LOGIN Failed');
          context.pop();
          showSnackBar(context, state.message, Colors.red);
        } else if (state is EmailNotVerified) {
          context.pop();
          showSnackBar(
            context,
            'Please verify your email first 😁',
            Colors.red,
          );
        } else if (state is SinginSuccess) {
          debugPrint('LOGIN DONE');
          context.pop();
          context.pushReplacementNamed(MyRoutes.mainScreen);
        } else if (state is ResetPasswordEmailIsSent) {
          context.pop();
          showSnackBar(context, 'Check your email 👌', Colors.green);
          context.pop();
        } else if (state is ForgetPasswordErrorOccured) {
          context.pop();
          showSnackBar(context, state.message, Colors.red);
        } else if (state is GoogleAuthUserNull) {
          context.pop();
        }
      },
      child: Container(),
    );
  }
}
