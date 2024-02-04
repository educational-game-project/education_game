import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum TokenEnum {
  accessToken,
  accessTokenExpires,
  refreshToken,
  refreshTokenExpires,
}

class TokensModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime? accessTokenExpires;
  final DateTime? refreshTokenExpires;
  final _storage = const FlutterSecureStorage();

  static int get accessTokenActiveSession => 1;
  static int get refreshTokenActiveSession => 3;

  TokensModel({
    this.accessToken = '',
    this.refreshToken = '',
    this.accessTokenExpires,
    this.refreshTokenExpires,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Future<TokensModel> read() async {
    final accessToken =
        await _storage.read(key: TokenEnum.accessToken.name) ?? '';
    final refreshToken =
        await _storage.read(key: TokenEnum.refreshToken.name) ?? '';
    final accessTokenExpires =
        await _storage.read(key: TokenEnum.accessTokenExpires.name) ?? '';
    final refreshTokenExpires =
        await _storage.read(key: TokenEnum.refreshTokenExpires.name) ?? '';
    return TokensModel(
      refreshToken: refreshToken,
      accessToken: accessToken,
      accessTokenExpires: DateTime.tryParse(accessTokenExpires),
      refreshTokenExpires: DateTime.tryParse(refreshTokenExpires),
    );
  }

  Future<void> save() async {
    debugPrint('saving token ${accessToken} ${refreshToken}');
    await _storage.write(
      key: TokenEnum.accessToken.name,
      value: accessToken,
    );
    await _storage.write(
      key: TokenEnum.refreshToken.name,
      value: refreshToken,
    );
    await _storage.write(
      key: TokenEnum.accessTokenExpires.name,
      value: DateTime.now()
          .add(Duration(days: accessTokenActiveSession))
          .toIso8601String(),
    );
    await _storage.write(
      key: TokenEnum.refreshTokenExpires.name,
      value: DateTime.now()
          .add(Duration(days: refreshTokenActiveSession))
          .toIso8601String(),
    );
  }

  void remove() {
    _storage.delete(
      key: TokenEnum.accessToken.name,
    );
    _storage.delete(
      key: TokenEnum.refreshToken.name,
    );
    _storage.delete(
      key: TokenEnum.accessTokenExpires.name,
    );
    _storage.delete(
      key: TokenEnum.refreshTokenExpires.name,
    );
  }

  @override
  List<Object?> get props =>
      [accessToken, refreshToken, accessTokenExpires, refreshTokenExpires];

  bool get isAccessTokenActive {
    if (accessToken == '') {
      return false;
    }

    if (accessTokenExpires == null) {
      return false;
    }

    if (accessTokenExpires!.difference(DateTime.now()).inDays >
        accessTokenActiveSession) {
      return false;
    }

    return true;
  }

  bool get isRefreshTokenActive {
    if (refreshToken == '') {
      return false;
    }

    if (refreshTokenExpires == null) {
      return false;
    }

    if (refreshTokenExpires!.difference(DateTime.now()).inDays >
        refreshTokenActiveSession) {
      return false;
    }

    return true;
  }

  bool get isAuthenticated {
    return isRefreshTokenActive && isAccessTokenActive;
  }

  TokensModel copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? accessTokenExpires,
    DateTime? refreshTokenExpires,
  }) {
    return TokensModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      accessTokenExpires: accessTokenExpires ?? this.accessTokenExpires,
      refreshTokenExpires: refreshTokenExpires ?? this.refreshTokenExpires,
    );
  }
}
