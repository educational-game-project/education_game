import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPage();
  }
}

class _LoginPage extends StatelessWidget {
  _LoginPage();

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
        return BackgroudWidget(
          isLoading: state.apiState is ApiLoading,
          onBack: () => Get.back(),
          onContinue: () {
            // if (formKey.currentState!.validate()) {
            if (controller.text.isNotEmpty) {
              context.read<AuthCubit>().login(controller.text.trim());
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Form(
                key: formKey,
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
                    ).fittedBox(),
                    Container(
                      alignment: Alignment.center,
                      width: 200.sp,
                      // height: 30.sp,
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
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.sp,
                            vertical: 8.sp,
                          ),
                          hintText: 'Masukkan namamu...',
                          fillColor: AppColors.neutral400,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                          color: AppColors.neutral900,
                          fontFamily: AppFonts.chubbyCrayon,
                          fontSize: 14.sp,
                          height: 0.8,
                        ),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[A-Za-z ']")),
                        ],
                      ),
                    ).fittedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
