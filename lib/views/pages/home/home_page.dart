import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/enums/api/auth_status_enum.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/login/login_page.dart';
import 'package:education_game/views/pages/pilihPermainan/pilih_permainan.dart';
import 'package:education_game/views/pages/playground_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiCubit(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primary500,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  AppImages.kiriBawah,
                  height: size.height * 0.30,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  AppImages.kananAtas,
                  height: size.height * 0.35,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.center,
                  width: size.width * 0.6,
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // tombol keluar
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Center(
                              child: SizedBox(
                                width: Get.width * 0.65,
                                height: Get.height * 0.7,
                                child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.primary100,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.06),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Image.asset(
                                              AppImages.think,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            children: [
                                              const Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    "Yakin mau keluar?",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.chubbyCrayon,
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Image.asset(
                                                        AppImages.batang,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () =>
                                                                Get.back(),
                                                            child: Image.asset(
                                                              AppImages.noGreen,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      AuthCubit>()
                                                                  .logout();
                                                              // Add Close App Action
                                                            },
                                                            child: Image.asset(
                                                              AppImages.yesRed,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          AppImages.tombolKeluar,
                          height: size.height * 0.19,
                        ),
                      ),
                      Image.asset(
                        AppImages.kiriAtas,
                        height: size.height * 0.15,
                      ),
                    ],
                  ),
                ),
              ),
              // tombol mulai
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    debugPrint('${state.tokens}');
                    switch (state.status) {
                      // case AuthStatus.authenticated:
                      //   Get.to(PlaygroundPage());
                      //   break;
                      // case AuthStatus.unauthenticated:
                      //   Get.to(LoginPage());
                      //   break;
                      case AuthStatus.authenticated:
                        Get.to(() => const PilihPermainan());
                        break;
                      case AuthStatus.unauthenticated:
                        Get.to(() => const LoginPage());
                        break;
                    }
                  },
                  child: Image.asset(
                    AppImages.kananBawah,
                    height: size.height * 0.25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
