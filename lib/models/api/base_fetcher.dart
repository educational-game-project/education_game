import 'package:dio/dio.dart';
import 'package:education_game/enums/api/fetcher_enum.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:education_game/models/api/endpoints.dart';
import 'package:education_game/models/api/server_exception.dart';
import 'package:education_game/models/token_model.dart';
import 'package:flutter/material.dart';

class BaseFetcher {
  static Dio _setupDio() {
    BaseOptions options = BaseOptions(
      // baseUrl: FlavorConfig.instance.variables["baseUrl"],
      baseUrl: EndPoints.host,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      // headers: {
      //   'accept': 'application/json',
      //   'X-Localization': lang,
      // },
    );

    Dio dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      request: true,
      requestBody: true,
    ));

    return dio;
  }

  final dio = _setupDio();
  TokensModel? token;

  BaseFetcher();

  Future<BaseResponse> post(
    String api, {
    Object? data,
  }) async {
    final response = await _fetch(
      api,
      data: data,
      type: FetcherEnum.post,
    );
    return response;
  }

  Future<BaseResponse> get(String api) async {
    final response = await _fetch(
      api,
      type: FetcherEnum.get,
    );
    return response;
  }

  Future<BaseResponse> delete(
    String api, {
    Object? data,
  }) async {
    final response = await _fetch(
      api,
      data: data,
      type: FetcherEnum.delete,
    );
    return response;
  }

  Future<BaseResponse> put(
    String api, {
    Object? data,
  }) async {
    final response = await _fetch(
      api,
      data: data,
      type: FetcherEnum.put,
    );
    return response;
  }

  Future<BaseResponse> _fetch(
    String url, {
    required FetcherEnum type,
    Object? data,
  }) async {
    try {
      token = await const TokensModel().read();

      var options = Options(headers: {
        if (token!.isAuthenticated)
          'Authorization': 'Bearer ${token?.accessToken}',
      });
      Response<Map<String, dynamic>> response;
      switch (type) {
        case FetcherEnum.get:
          response = await dio.get(
            url,
            options: options,
          );
          break;
        case FetcherEnum.post:
          response = await dio.post(
            url,
            options: options,
            data: data,
          );
          break;
        case FetcherEnum.put:
          response = await dio.put(
            url,
            options: options,
            data: data,
          );
          break;
        case FetcherEnum.delete:
          response = await dio.delete(
            url,
            options: options,
            data: data,
          );
          break;
      }

      final baseResponse = BaseResponse.fromJson(response.data ?? {});

      debugPrint('response raw ${baseResponse.data}');

      if (baseResponse.statusCode == 200 || baseResponse.statusCode == 201) {
        return baseResponse;
      } else {
        throw ServerException.fromResponse(response);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw ServerException.fromResponse(error.response!);
      } else {
        rethrow;
      }
    }
  }
}
