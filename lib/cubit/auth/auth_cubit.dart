import 'dart:async';
import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/enums/api/auth_status_enum.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/repositories/params/refresh_tokens_params.dart';
import 'package:education_game/views/pages/chooseGame/choose_game.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiCubit _apiCubit = ApiCubit();
  StreamSubscription? apiSubs;

  AuthCubit() : super(AuthState.unauthenticated()) {
    apiSubs = _apiCubit.stream.listen((event) async {
      debugPrint('state auth : $event');
      emit(state.copyWith(apiState: event));

      if (event is LoginSuccess) {
        debugPrint('LOGIN SUCCESS  ${event.responses.user}');
        emit(AuthState.authenticated(
            tokens: event.responses.tokens, user: event.responses.user));
        await state.tokens?.save();
        debugPrint(
            'tokens saved ${(await state.tokens?.read())?.accessToken.toString()}');
        Get.offAll(() => const ChooseGame());
      }

      if (event is LogoutSuccess) {
        await state.tokens?.remove();
        emit(AuthState.unauthenticated());
        exitApp();
      }

      if (event is RefreshTokensSuccess) {
        debugPrint('REFRESH TOKENS ${event.responses.tokens}');
        event.responses.tokens.save();
        emit(AuthState.authenticated(tokens: event.responses.tokens));
      }
    });

    initialAuth();
  }

  Future<void> initialAuth() async {
    TokensModel tokens = await const TokensModel().read();
    debugPrint('storage : $tokens');
    debugPrint('is auth : ${tokens.isAuthenticated.toString()}');
    if (tokens.isAuthenticated) {
      emit(AuthState.authenticated(tokens: tokens));
    }
    if (tokens.isRefreshTokenActive) {
      _apiCubit
          .refreshTokens(RefreshTokenParams(refreshToken: tokens.refreshToken));
    }
  }

  void login(String name) {
    _apiCubit.login(LoginParams(name: name));
  }

  void logout() {
    debugPrint('click logout : ${state.status}');
    switch (state.status) {
      case AuthStatus.authenticated:
        _apiCubit.logout();
        break;
      case AuthStatus.unauthenticated:
        exitApp();
        break;
    }
  }

  void exitApp() => SystemNavigator.pop();
  // await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
