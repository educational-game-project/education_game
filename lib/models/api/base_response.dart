// import 'package:dio/dio.dart';
import 'package:education_game/models/api/error_catch.dart';
// import 'package:education_game/models/api/server_exception.dart';
// import 'package:flutter/material.dart';

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

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 400,
      status: json['status'] ?? 'error',
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
