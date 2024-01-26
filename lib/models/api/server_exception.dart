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

  factory ServerException.fromResponse(Response response) {
    final resp = ServerException(
      baseResponse: BaseResponse.fromResponse(response),
      code: response.statusCode,
      message: response.statusMessage,
    );
    debugPrint('Info : ${resp.message} ${resp.code}');
    return resp;
  }
}
