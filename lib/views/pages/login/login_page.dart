import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/views/widgets/background_widget.dart';
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
        if (data is ApiError) {
          Get.snackbar('Error', '${data.data.message}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: const GeneralAppbar(),
          backgroundColor: AppColors.primary500,
          body: Form(
            key: formKey,
            child: BackgroudWidget(
              onBack: () => Get.back(),
              onContinue: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().login(controller.text);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Namaku:',
                    style: TextStyle(
                      color: AppColors.neutral900,
                      fontFamily: AppFonts.clapHand,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: List.filled(
                          3,
                          const BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                            spreadRadius: 2,
                          ),
                          growable: true),
                    ),
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan namamu...',
                        fillColor: AppColors.neutral400,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        color: AppColors.neutral900,
                        fontFamily: AppFonts.chubbyCrayon,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
