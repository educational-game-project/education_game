import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/enums/api/auth_status_enum.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/chooseGame/choose_game.dart';
import 'package:education_game/views/pages/login/login_page.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:education_game/views/widgets/dialog/logout_dialog.dart';
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
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        void onExit() async {
          var isLogout = await AppDialog().logoutDialog();
          if (isLogout ?? false) authCubit.logout();
        }

        void onStart() {
          switch (state.status) {
            case AuthStatus.authenticated:
              Get.to(() => const ChooseGame());
              break;
            case AuthStatus.unauthenticated:
              Get.to(() => const LoginPage());
              break;
          }
        }

        return BackgroudWidget(
          isLoading: state.apiState is ApiLoading,
          onStart: onStart,
          onExit: onExit,
          child: Image.network(
            AppImages.center,
            width: size.width * 0.55,
          ),
        );
      },
    );
  }
}
