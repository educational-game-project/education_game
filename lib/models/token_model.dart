import 'package:education_game/utils/storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  static int get accessTokenActiveSession => 1;
  static int get refreshTokenActiveSession => 3;

  const TokensModel({
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
        await Storage.local.read(key: TokenEnum.accessToken.name) ?? '';
    final refreshToken =
        await Storage.local.read(key: TokenEnum.refreshToken.name) ?? '';
    final accessTokenExpires =
        await Storage.local.read(key: TokenEnum.accessTokenExpires.name) ?? '';
    final refreshTokenExpires =
        await Storage.local.read(key: TokenEnum.refreshTokenExpires.name) ?? '';
    return TokensModel(
      refreshToken: refreshToken,
      accessToken: accessToken,
      accessTokenExpires: DateTime.tryParse(accessTokenExpires),
      refreshTokenExpires: DateTime.tryParse(refreshTokenExpires),
    );
  }

  Future<void> save() async {
    debugPrint('saving token $accessToken $refreshToken');
    await Storage.local.write(
      key: TokenEnum.accessToken.name,
      value: accessToken,
    );
    await Storage.local.write(
      key: TokenEnum.refreshToken.name,
      value: refreshToken,
    );
    await Storage.local.write(
      key: TokenEnum.accessTokenExpires.name,
      value: DateTime.now()
          .add(Duration(days: accessTokenActiveSession))
          .toIso8601String(),
    );
    await Storage.local.write(
      key: TokenEnum.refreshTokenExpires.name,
      value: DateTime.now()
          .add(Duration(days: refreshTokenActiveSession))
          .toIso8601String(),
    );
  }

  Future<void> remove() async {
    await Storage.local.delete(key: TokenEnum.accessToken.name);
    await Storage.local.delete(key: TokenEnum.refreshToken.name);
    await Storage.local.delete(key: TokenEnum.accessTokenExpires.name);
    await Storage.local.delete(key: TokenEnum.refreshTokenExpires.name);
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
