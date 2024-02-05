import 'package:dartz/dartz.dart';
import 'package:education_game/models/api/base_fetcher.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/api/endpoints.dart';
import 'package:education_game/models/api/server_exception.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/repositories/params/refresh_tokens_params.dart';
import 'package:education_game/repositories/responses/login_responses.dart';
import 'package:education_game/repositories/responses/refresh_tokens_responses.dart';

class ApiRepository {
  final BaseFetcher _fetcher = BaseFetcher();

  Future<Either<BaseResponse, T>> _handler<T>(
      {required Future<BaseResponse> api}) async {
    try {
      final resp = await api;
      return Right(resp as T);
    } on ServerException catch (e) {
      return Left(e.errorBaseResponse);
    }
  }

  Future<Either<BaseResponse, LoginResponses>> login(LoginParams params) async {
    try {
      final resp = await api;
      return Right(resp as T);
    } on ServerException catch (e) {
      return Left(e.ErrorBaseResponse);
    }
  }

  Future<Either<BaseResponse, LoginResponses>> login(LoginParams params) async {
    return _handler<LoginResponses>(
      api: _fetcher.post(
        EndPoints.loginUrl,
        data: params.toJson,
      ),
    );
  }

  Future<Either<BaseResponse, RefreshTokensResponses>> refreshTokens(
      RefreshTokenParams params) async {
    return _handler(
      api: _fetcher.post(
        EndPoints.refreshTokenUrl,
        data: params.toJson,
      ),
    );
  }

  // Future<BaseResponse> logout() async {
  //   try {
  //     final resp = await _fetcher.post(
  //       EndPoints.logoutUrl,
  //     );
  //     return BaseResponse(message: resp.message);
  //   } on ServerException catch (e) {
  //     return Left(e.ErrorBaseResponse);
  //   }
  // }
}
