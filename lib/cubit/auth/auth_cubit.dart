import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/enums/api/auth_status_enum.dart';
import 'package:education_game/models/token_model.dart';
import 'package:education_game/models/user/user_model.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiCubit _apiCubit = ApiCubit();
  StreamSubscription? apiSubs;

  AuthCubit() : super(AuthState.unauthenticated()) {
    apiSubs = _apiCubit.stream.listen((event) {
      emit(state.copyWith(apiState: event));

      if (event is LoginSuccess) {
        if (event.responses.baseResponse.status == 'success') {
          debugPrint('tokens ${event.responses.tokens}');
          emit(state.copyWith(
              user: event.responses.user, tokens: event.responses.tokens));
          debugPrint('tokens ${state.tokens}');
          state.tokens?.save();
          Get.offAll(HomePage());
        }
      }
    });

    initialAuth();
  }

  Future<void> initialAuth() async {
    TokensModel tokens = await TokensModel().read();
    switch (tokens.isAuthenticated) {
      case true:
        emit(state.copyWith(tokens: tokens));
        break;
    }
  }

  void login(String name) {
    _apiCubit.login(LoginParams(name: name));
  }
}
