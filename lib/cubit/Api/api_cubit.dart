// import 'dart:js_util';
import 'package:education_game/cubit/Api/api_helper.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/repositories/api_repository.dart';
import 'package:education_game/repositories/params/game_param.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/repositories/params/refresh_tokens_params.dart';
import 'package:education_game/repositories/responses/game_response.dart';
import 'package:education_game/repositories/responses/login_responses.dart';
import 'package:education_game/repositories/responses/refresh_tokens_responses.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final repository = ApiRepository();

  ApiCubit() : super(ApiInitial());

  Future<void> login(LoginParams params) async {
    emit(const ApiLoading());

    final resp = await repository.login(params);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(
        LoginSuccess(params, success),
      ),
    );
  }

  Future<void> logout() async {
    emit(const ApiLoading());

    final resp = await repository.logout();
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(
        LogoutSuccess(success),
      ),
    );
  }

  Future<void> refreshTokens(RefreshTokenParams params) async {
    emit(const ApiLoading());

    final resp = await repository.refreshTokens(params);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(
        RefreshTokensSuccess(params, success),
      ),
    );
  }

  Future<void> getListGame(GameParam param) async {
    emit(const ApiLoading());

    final resp = await repository.getListGame(param);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(GetListGameSuccess(param, success)),
    );
  }

  Future<void> getLevel(GameParam param) async {
    emit(const ApiLoading());

    final resp = await repository.getLevel(param);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(GetLevelSuccess(param, success)),
    );
  }

  Future<void> recordGame(GameParam param) async {
    emit(const ApiLoading());

    final resp = await repository.recordGame(param);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(RecordGameSuccess(param, success)),
    );
  }

  Future<void> getLeaderBoard(GameParam param) async {
    emit(const ApiLoading());

    final resp = await repository.getLeaderBoard(param);
    resp.fold(
      (failure) => emit(ApiError(failure)),
      (success) => emit(GetLeaderBoardSuccess(param, success)),
    );
  }
}
