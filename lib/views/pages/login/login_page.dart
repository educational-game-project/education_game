import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/models/api/endpoints.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/appbar/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPage();
  }
}

class _LoginPage extends StatelessWidget {
  _LoginPage({super.key});

  final controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          (previous.tokens?.isAuthenticated ?? false) == false &&
          current.tokens?.isAuthenticated == true,
      listener: (BuildContext context, AuthState state) {
        final data = state.apiState;
        if (data is LoginSuccess) {
          Get.snackbar('${data.responses.baseResponse.status}',
              '${data.responses.baseResponse.message ?? ''} ${data.responses.tokens}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GeneralAppbar(),
          backgroundColor: AppColors.primary500,
          body: Form(
            key: formKey,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(controller.text);
                        }
                      },
                      child: Image.asset(
                        AppImages.kananBawah,
                        height: size.height * 0.25,
                      ),
                    ),
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
