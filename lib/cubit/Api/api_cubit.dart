// import 'dart:js_util';

import 'package:bloc/bloc.dart';
import 'package:education_game/cubit/Api/api_helper.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/repositories/api_repository.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/repositories/responses/login_responses.dart';
import 'package:equatable/equatable.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final repository = ApiRepository();

  ApiCubit() : super(ApiInitial());

  Future<void> login(LoginParams params) async {
    emit(ApiLoading());

    final resp = await repository.login(params);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(
        LoginSuccess(params, success),
      ),
    );
  }
}
