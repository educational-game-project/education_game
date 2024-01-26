import 'package:dio/dio.dart';
import 'package:education_game/models/api/error_catch.dart';
import 'package:education_game/models/api/server_exception.dart';
import 'package:flutter/material.dart';

class BaseResponse<T> {
  final bool? success;
  final int? statusCode;
  final String? status;
  final String? message;
  final String? serverTime;
  final T? data;
  final ErrorCatch? error;

  BaseResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.status,
    this.serverTime,
    this.error,
  });

  factory BaseResponse.fromResponse(Response response) {
    return BaseResponse(
        data: response.data,
        statusCode: response.statusCode,
        message: response.statusMessage,
        success: (response.statusCode == 200 || response.statusCode == 201));
  }

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'],
      statusCode: json['status_code'],
      status: json['status'],
      message: handleMessage(json['message']),
      serverTime: json['server_time'],
      data: json['data'],
      error: handleError(json['error']),
    );
  }

  static dynamic handleMessage(json) {
    if (json == null) return null;
    if (json is List) return List.from(json).map((e) => e).toList().join(",");
    if (json is! List && json is! String) return null;
    return json;
  }

  static dynamic handleError(json) {
    if (json == null || json is! List) return null;
    if (List.from(json).isEmpty) return null;
    return ErrorCatch.fromJson(List.from(json)[0]);
  }

  factory BaseResponse.handleResp({required Response response}) {
    try {
      BaseResponse<T> baseResponse = BaseResponse.fromJson(response.data);
      debugPrint(
          'Response Status : ${baseResponse.statusCode.toString()} ${baseResponse.message.toString()}');
      if ((baseResponse.statusCode == 200 || baseResponse.statusCode == 201) &&
          baseResponse.status == 'success') {
        return baseResponse;
      } else if (baseResponse.message == 'Unauthorized') {
        return baseResponse;
      }
      return baseResponse;
    } catch (error) {
      debugPrint('Response Error : ${error}');
      throw ServerException.fromResponse(response);
    }
  }

  BaseResponse copyWith({
    bool? success,
    int? statusCode,
    String? status,
    String? message,
    String? serverTime,
    T? data,
    ErrorCatch? error,
  }) {
    return BaseResponse(
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
      status: status ?? this.status,
      serverTime: serverTime ?? this.serverTime,
      error: error ?? this.error,
    );
  }
}
