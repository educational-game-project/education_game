import 'package:dio/dio.dart';
import 'package:education_game/models/api/base_response.dart';
import 'package:flutter/material.dart';

class ServerException implements Exception {
  final String? message;
  final int? code;
  final BaseResponse? baseResponse;

  ServerException({
    this.message,
    this.code,
    this.baseResponse,
  });

  BaseResponse get ErrorBaseResponse {
    return baseResponse ??
        BaseResponse(
          message: message,
          statusCode: code,
        );
  }

  factory ServerException.fromResponse(Response response) {
    final resp = ServerException(
      baseResponse: BaseResponse.fromJson(response.data),
      code: response.statusCode,
      message: response.statusMessage,
    );
    debugPrint(
        'ERROR ${resp.baseResponse?.statusCode} ${resp.baseResponse?.message}');
    return resp;
  }
}
