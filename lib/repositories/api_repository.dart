import 'package:dartz/dartz.dart';
import 'package:education_game/models/api/base_fetcher.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/api/endpoints.dart';
import 'package:education_game/models/api/server_exception.dart';
import 'package:education_game/repositories/params/game_param.dart';
import 'package:education_game/repositories/params/login_params.dart';
import 'package:education_game/repositories/params/refresh_tokens_params.dart';
import 'package:education_game/repositories/responses/game_response.dart';
import 'package:education_game/repositories/responses/login_responses.dart';
import 'package:education_game/repositories/responses/refresh_tokens_responses.dart';

class ApiRepository {
  final BaseFetcher _fetcher = BaseFetcher();

  Future<Either<BaseResponse, LoginResponses>> login(
    LoginParams params,
  ) async {
    try {
      final resp = await _fetcher.post(
        EndPoints.loginUrl,
        data: params.toJson,
      );
      return Right(LoginResponses(resp));
    } on ServerException catch (e) {
      return Left(e.errorBaseResponse);
    }
  }

  Future<Either<BaseResponse, LoginResponses>> logout() async {
    try {
      final resp = await _fetcher.post(
        EndPoints.logoutUrl,
        // data: params.toJson,
      );
      return Right(LoginResponses(resp));
    } on ServerException catch (e) {
      return Left(e.errorBaseResponse);
    }
  }

  Future<Either<BaseResponse, RefreshTokensResponses>> refreshTokens(
    RefreshTokenParams params,
  ) async {
    try {
      final resp =
          await _fetcher.post(EndPoints.refreshTokenUrl, data: params.toJson);
      return Right(RefreshTokensResponses(resp));
    } on ServerException catch (e) {
      return Left(e.errorBaseResponse);
    }
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

  // =========== Game ===========
  Future<Either<BaseResponse, GameResponse>> gameApi(
    GameParam param,
    String endpoint,
  ) async {
    try {
      final resp = await _fetcher.post(
        endpoint,
        data: param.toJson,
      );
      return Right(GameResponse(resp));
    } on ServerException catch (e) {
      return Left(e.errorBaseResponse);
    }
  }

  Future<Either<BaseResponse, GameResponse>> getListGame(
    GameParam param,
  ) async {
    return gameApi(param, EndPoints.gameUrl);
  }

  Future<Either<BaseResponse, GameResponse>> getLevel(
    GameParam param,
  ) async {
    return gameApi(param, EndPoints.levelUrl);
  }

  Future<Either<BaseResponse, GameResponse>> recordGame(
    GameParam param,
  ) async {
    return gameApi(param, EndPoints.recordUrl);
  }

  Future<Either<BaseResponse, GameResponse>> getLeaderBoard(
    GameParam param,
  ) async {
    return gameApi(param, EndPoints.leaderboardUrl);
  }
}
